package characters {
	
	import characters.Player
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	
	
	public class AsciiPlayer extends Player {
		
		
		public function AsciiPlayer(infectedRefusalProbability) {
			super(infectedRefusalProbability);
			unhighlightForInteraction();
			asciiCharge.visible = false;
		}

		protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
			getSelection().gotoAndPlay(1);
		}

		override protected function unhighlightForInteraction(): void {
			if (GlobalState.draggableCharacter != this) {
				getSelection().gotoAndStop(1);
				getSelection().visible = false;
			}
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

		override protected function initializeAction() {
			currentRoom.highlightReachableRooms(true);
			GlobalState.draggableCharacter = this;
		}

		override public function finalizeAction() {
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
			this.asciiCharge.owner = this;
		}

		override public function equipSyringe() {
			trace(this, "has equipped test syringe")
			this.asciiSyringe.visible = true;
			this.asciiSyringe.owner = this;
		}
	}
}
