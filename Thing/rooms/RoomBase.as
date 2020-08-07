package rooms
{
    import characters.Interactable;
    import flash.events.Event;
    import characters.Character;
    import characters.Thing;
    import characters.Player;
    import events.CharacterEvent;

    public class RoomBase extends Interactable {
        // Bookkeeping and game logic only

        public var guests: Array = [];
		public var accessibleRooms: Array = [];
		public var adjacentRooms: Array = [];

		protected var isReachable: Boolean = false;

		public function get IsReachable(): Boolean {
			return isReachable;
		}

		public function set IsReachable(value: Boolean): void {
			isReachable = value;
            dispatchEvent(new Event(isReachable ? GlobalState.ROOM_BECAME_REACHABLE : GlobalState.ROOM_BECAME_UNREACHABLE)) 
        }

        public function setAccessibleRoomsReachability(value: Boolean): void {
            for each(var room:RoomBase in accessibleRooms)
            {
                room.IsReachable = value;
            }
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
				return item.isVisible
			});
		}

        public function admitCharacter(character: Character) {
            trace (character, "enters", this, "@", x, y);

            guests.push(character);
			
			Things.forEach(function (thing: * ) {
				thing.refreshVisibility()
			});
        }

        public function releaseCharacter(character: Character) {
            guests.removeAt(guests.indexOf(character));

            setAccessibleRoomsReachability(false);

            Things.forEach(function (thing: * ) {
                    thing.refreshVisibility()
            });
        }

		public function register(character: Character) {
            character.leaveRoom();
            character.enterRoom(this);
            dispatchEvent(new CharacterEvent(GlobalState.CHARACTER_PLACED_IN_ROOM, character));
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