package characters {
	
	import characters.Player
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import items.AsciiSyringe;
	import asciiRooms.AsciiRoomBase;
	
	public class AsciiPlayer extends Player {
		
		public function AsciiPlayer(infectedRefusalProbability, spawnThing) {
			super(infectedRefusalProbability, spawnThing);
			unhighlightForInteraction();
			asciiSyringe.visible = false;
			asciiCharge.visible = false;
			asciiMarker.visible = true;
			gotoAndStop(24); // where walking animation stops
		}

		override public function getSyringe(): MovieClip {
			return asciiSyringe;
		}

		override public function getCharge(): MovieClip {
			return asciiCharge;
		}

		override protected function highlightForInteraction(): void {
			if (currentRoom != null) //TODO:
			{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y);}
		}

		override protected function unhighlightForInteraction(): void {
			if (GlobalState.draggableCharacter != this) {
				if (currentRoom != null) //TODO:
				{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y);}
			}
		}

		override protected function markAlreadyActed(): void {
			asciiMarker.visible = false
		}

		override protected function markReadyToAct(): void {
			asciiMarker.visible = true
		}

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (!AlreadyActed) {
				highlightForInteraction();
			}
		}

		override protected function interactOnMouseOut(e: MouseEvent): void {
			if (!AlreadyActed) {
				unhighlightForInteraction();
			}				
		}

		override protected function interactOnMouseClick(e: MouseEvent): void {
			attemptAction();
		}

		// TODO: this one inadvertedly circumvents order refusal check?
		// also no check for having acted?
		public function selectAsActiveCharacter(): void {
			highlightForInteraction();
			initializeAction();
		}

		public function unselectAsActiveCharacter(): void {
			unhighlightForInteraction();
		}

		override protected function initializeAction() {
			if (previousRoom) {
				previousRoom.unhighlightReachableRooms();
			}
			currentRoom.highlightReachableRooms();
			GlobalState.draggableCharacter = this;
		}

		override public function finalizeAction() {
			previousRoom.unhighlightReachableRooms();
			currentRoom.unhighlightReachableRooms();
			GlobalState.draggableCharacter = null;
			AlreadyActed = true;

			unhighlightForInteraction();
		}

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}
}
