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

		public function putIn(character: Character) {
			register(character);



			moveSmoothly(character, computePositionInRoom(character));
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
		protected function computePositionInRoom(whom: Character): Array {
			var offset_x = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * width / 2;
			var correction_x = offset_x < 0 ? whom.width / 2 : -whom.width / 2;
			var destinationX = x + offset_x + correction_x;

			var offset_y = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * height / 2;
			var correction_y = offset_y < 0 ? whom.height / 2 : -whom.height / 2;
			var destinationY = y + offset_y + correction_y;

			return [destinationX, destinationY];
		}

		protected function moveSmoothly(whom: MovieClip, destination: Array) {
			trace("not moving smoothly");
			whom.x = destination[0]
			whom.y = destination[1]
			return;
			
			var destinationX = destination[0];
			var destinationY = destination[1];

			var numSteps = 10;
			var stepX = (destinationX - whom.x) / numSteps;
			var stepY = (destinationY - whom.y) / numSteps;
			const epsilon = 10;

			var motionInterval = setInterval(function (whom: * ) {
					if (Math.abs(whom.x - destinationX) > epsilon) {
						whom.x += stepX;
					}

					if (Math.abs(whom.y - destinationY) > epsilon) {
						whom.y += stepY
					}

					if (Math.abs(whom.x - destinationX) <= epsilon && Math.abs(whom.y - destinationY) <= epsilon) {
						clearInterval(motionInterval);
					}

				}, 10,
				whom);

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