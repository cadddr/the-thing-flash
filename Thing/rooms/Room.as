package rooms {
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import characters.*;
	import flash.utils.*;
	import characters.Interactable;

	public class Room extends RoomBase {
		// Appearance and interactions

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
					register(draggableCharacter);

				}

				setAccessibleRoomsReachability(false);
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
	}
}