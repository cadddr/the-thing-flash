package rooms
{
    import characters.Interactable;
    import flash.events.Event;
    import characters.Character;
    import characters.Thing;
    import characters.Player;
    import events.CharacterEvent;
    import flash.display.MovieClip;

    public class RoomBase extends Interactable {
        // Bookkeeping and game logic only

        public var guests: Array = [];
		/// populated from LevelBase.initializeRooms in accordance with adjacency matrix
		public var accessibleRooms: Array = [];
		public var adjacentRooms: Array = [];
		public var interactables: Array = [];

		/// Belongs in a separate mixin
		public var passiveAbility: Function;

		public function enhancePlayers() {
			if (passiveAbility != null) {
				passiveAbility(this);
			}
		}

		// this is duplicated in special room classes
		public static var PASSIVE_ABILITY_DISPENSE_EXPLOSIVES = function (room:RoomBase):void
		{			
			var eligiblePlayers = room.guests.filter(function(item:*) {
				return item is Player && !item.AlreadyActed
			});
			
			eligiblePlayers.forEach(function(item:*) {item.equipExplosiveCharge()});
		}

		public static var PASSIVE_ABILITY_DISPENSE_SYRINGES = function (room:RoomBase):void
		{			
			var eligiblePlayers = room.guests.filter(function(item:*) {
				return item is Player && !item.AlreadyActed
			});
			
			eligiblePlayers.forEach(function(item:*) {item.equipSyringe()});
		}
		/// End belongs in a separate mixin

		public function isReachableFrom(room: RoomBase): Boolean {
			return accessibleRooms.indexOf(room) != -1;
		}

		public function highlightReachableRooms(): void {
            throw new Error("Not implemented");
		}

		public function unhighlightReachableRooms(): void {
            throw new Error("Not implemented");
		}

        public function get Things(): Array {
 			return guests.filter(function (item: * ) {
 				return item is Thing
 			});
 		}

 		public function get Players(): Array {
 			return guests.filter(function (item: * ) {
 				return item is Player
 			});
 		}

		public function get InfectedPlayers(): Array {
			return Players.filter(function (item: * ) {
				return item.IsInfected
			});
		}

		public function get NonInfectedPlayers() {
			return Players.filter(function (item: * ) {
				return !item.IsInfected
			});
		}

		//tells how much the things are outnumbered by non-things
		public function get NonInfectedPlayerMargin(): int {
			return NonInfectedPlayers.length - Things.length - InfectedPlayers.length;
		}

		public function getRoommates(player: Player) {
			return Players.filter(function (item: * ) {
				return item != player
			});
		}

		public function get IsTakenOver(): Boolean {
			return NonInfectedPlayerMargin <= 0;
		}

		public function get VisibleThings() {
			return Things.filter(function (item: * ) {
				return item.IsVisible
			});
		}

		public function refreshThingsVisibility(): void {
			for each (var thing: * in Things) {
				thing.refreshVisibility();
			}
		}

        public function admitCharacter(character: Character) {
            trace (character, "enters", this, "@", x, y);

            guests.push(character);
			
			Things.forEach(function (thing: * ) {
				thing.refreshVisibility()
			});

			dispatchEvent(new CharacterEvent(GlobalState.CHARACTER_PLACED_IN_ROOM, character));
        }

        public function releaseCharacter(character: Character) {
            guests.removeAt(guests.indexOf(character));

            // unhighlightReachableRooms(); // handled in AsciiPlayer.finalizeAction

            Things.forEach(function (thing: * ) {
                thing.refreshVisibility()
            });
        }

		public function register(character: Character) {
			//leave previous room & refresh visibility
			if (character.currentRoom) {
				character.currentRoom.releaseCharacter(character)
				character.previousRoom = character.currentRoom;		
			}
			character.currentRoom = this;
            this.admitCharacter(character);
		}

		public function killGuests() {
			//cloning to avoid mutability problems
			var tempChars = guests.concat();
			tempChars.forEach(function (item: * ) {
				item.die()
			});
		}

		public function revealInfectedPlayers() {
			guests.forEach(function (item: * ) {
				if (item is Player) item.revealItself()
			});
		}
    }
}