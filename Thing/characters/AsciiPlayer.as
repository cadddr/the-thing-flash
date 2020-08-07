package characters {
	
	import characters.Player
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import items.AsciiSyringe;
	import asciiRooms.AsciiRoomBase;
	
	
	public class AsciiPlayer extends Player {
		
		
		public function AsciiPlayer(infectedRefusalProbability) {
			super(infectedRefusalProbability);
			unhighlightForInteraction();
			asciiSyringe.visible = false;
			asciiCharge.visible = false;
			asciiMarker.visible = true;
		}

		protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
			getSelection().gotoAndPlay(1);
			if (currentRoom != null)
			{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y);}
		}

		override protected function unhighlightForInteraction(): void {
			if (GlobalState.draggableCharacter != this) {
				getSelection().gotoAndStop(1);
				getSelection().visible = false;
				if (currentRoom != null)
				{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y, false);}
			}
		}

		override protected function markInactive(): void {
			asciiMarker.visible = false
		}

		override protected function markReady(): void {
			asciiMarker.visible = true
		}

		override protected function interactOnMouseDown(e: MouseEvent): void {}

		override protected function interactOnMouseClick(e: MouseEvent): void {
			if (!alreadyActed) {
				if (this.isInfected) {
					trace("Is", this, "going to refuse to execute the order?");
					if (Utils.getRandom(6, 1) <= infectedRefusalProbability) {
						this.revealItself();
						return;
					}
				}
				initializeAction();
			}
		}

		public function selectAsActiveCharacter(): void {
			highlightForInteraction();
			initializeAction();
		}

		public function unselectAsActiveCharacter(): void {
			unhighlightForInteraction();
		}

		override protected function initializeAction() {
			if (previousRoom) {
				previousRoom.setAccessibleRoomsReachability(false);
			}
			currentRoom.setAccessibleRoomsReachability(true);
			GlobalState.draggableCharacter = this;
		}

		override public function finalizeAction() {
			previousRoom.setAccessibleRoomsReachability(false);
			currentRoom.setAccessibleRoomsReachability(false);
			GlobalState.draggableCharacter = null;
			IsInactive = true;

			unhighlightForInteraction();
		}

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}

		override public function equipExplosiveCharge() {
			trace(this, "has equipped explosive charge")
			this.asciiCharge.visible = true;
			this.asciiCharge.mouseEnabled = true;
			this.asciiCharge.owner = this;
		}

		override public function equipSyringe() {
			trace(this, "has equipped test syringe")
			this.asciiSyringe.equip(this)
		}
	}
}
