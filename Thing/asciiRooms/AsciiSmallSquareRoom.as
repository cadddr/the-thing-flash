package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.Room;
	import characters.*;
	import flash.events.*;
	import items.AsciiGeneratorSwitch;
	import flash.geom.ColorTransform;
	import GlobalState;
	
	
	public class AsciiSmallSquareRoom extends Room {
		
		public function AsciiSmallSquareRoom() {
		}
		
		override protected function computePositionInRoom(whom: Character): Array {
			return [x + 25, y + 40.25];
		}

		override protected function interactOnMouseUp(event: MouseEvent): void {}

		//undrags the player and puts it into the room
		override protected function interactOnMouseClick(event: MouseEvent): void {
			if (IsReachable) {
				var draggableCharacter = GlobalState.draggableCharacter;

				if (draggableCharacter != null) {
					draggableCharacter.finalizeAction();
					putIn(draggableCharacter);

				}

				highlightReachableRooms(false);
			}
		}

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (GlobalState.draggableCharacter) {
				if (IsReachable) {
					highlightSelected();
				} else {
					highlightRestricted();
				}
			}
		}

		override public function unhighlight() {
			asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 31, 64, 104);
		}

		override public function highlightSelected() {
			asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 255, 255, 255);
		}

		override public function highlightReachable() {
			asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 242, 175, 101);
		}

		override public function highlightRestricted() {
			asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 228, 63, 90);
		}
	}
}
