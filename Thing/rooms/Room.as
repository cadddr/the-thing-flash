package rooms {
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import characters.*;
	import flash.utils.*;
	import characters.Interactable;

	public class Room extends Interactable {
		public var guests: Array = [];

		public var accessibleRooms: Array = [];
		public var adjacentRooms: Array = [];

		protected var isReachable: Boolean = false;

		public function get IsReachable(): Boolean {
			return isReachable;
		}

		public function set IsReachable(value: Boolean) {
			isReachable = value;

			if (value) {
				highlightReachable();
			} else {
				unhighlight();
			}
		}

		public function Room() {		
			
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

		

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (!GlobalState.draggableCharacter || IsReachable) {
				highlightSelected();
			} else {
				highlightRestricted();
			}
		}

		override protected function interactOnMouseOut(e: MouseEvent): void {
			if (IsReachable) {
				highlightReachable();
			} else {
				unhighlight();
			}
		}

		//undrags the player and puts it into the room
		override protected function interactOnMouseUp(event: MouseEvent): void {
			if (IsReachable) {
				var draggableCharacter = GlobalState.draggableCharacter;

				if (draggableCharacter != null) {
					draggableCharacter.finalizeAction();
					putIn(draggableCharacter);

				}

				highlightReachableRooms(false);
			}
		}

		public function unhighlight() {
			gotoAndStop(1);
		}

		public function highlightSelected() {
			gotoAndStop(2);
		}

		public function highlightReachable() {
			gotoAndStop(3);
		}

		public function highlightRestricted() {
			gotoAndStop(4);
		}

		public function highlightReachableRooms(shouldHighlight: Boolean) {
			accessibleRooms.forEach(function (room: * ) {
				room.IsReachable = shouldHighlight;
			});
		}

		public function putIn(character: Character, stageX: Number=0, stageY: Number=0) {
			trace (character, "enters", this, "@", x, y);
			register(character);

			// if (stageX == 0 && stageY == 0) {
			// 	trace('resetting position');
			// 	stageX = character.x;
			// 	stageY = character.y;
			// }

			var destination = computePositionInRoom(stageX, stageY, character.width, character.height);
			trace ('position in room', destination);

			// character.x = destination[0]
			// character.y = destination[1]

			character.moveTo(destination[0], destination[1]);
		}

		public function register(character: Character) {
			highlightReachableRooms(false);

			//leave previous room
			character.leaveRoom();

			guests.push(character);
			character.currentRoom = this;

			Things.forEach(function (thing: * ) {
				thing.refreshVisibility()
			});
		}

		// puts a character at a random location within a room
		protected function computePositionInRoom(whomX: Number, whomY: Number, whomW: Number, whomH: Number): Array {
			throw ""
			var offset_x = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * width / 2;
			var correction_x = offset_x < 0 ? whomW / 2 : -whomW / 2;
			var destinationX = x + offset_x + correction_x;

			var offset_y = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * height / 2;
			var correction_y = offset_y < 0 ? whomH / 2 : -whomH / 2;
			var destinationY = y + offset_y + correction_y;

			return [destinationX, destinationY];
		}

		public function getOut(character: Character) {
			var characterIndex = guests.indexOf(character);
			guests.splice(characterIndex, 1);

			Things.forEach(function (thing: * ) {
				thing.refreshVisibility()
			});
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