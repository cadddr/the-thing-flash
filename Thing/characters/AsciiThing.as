package characters {
	
	import flash.display.MovieClip;
	import characters.*;
	import Utils;
	import GlobalState;
	import flash.events.*
	import flash.geom.ColorTransform;
	
	public class AsciiThing extends Thing {
		
		public function AsciiThing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability) {
			super(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability);
			unhighlightForInteraction();
		}

		protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
				getSelection().visible = false;
		}

		// TODO: extract condition to logic
		override protected function interactOnMouseOver(e:MouseEvent): void {
			if(GlobalState.draggableCharacter && currentRoom == GlobalState.draggableCharacter.currentRoom) {
				highlightForInteraction();
			}
		}
		
		override protected function interactOnMouseOut(e:MouseEvent): void {
				unhighlightForInteraction();
		}

		override protected function interactOnMouseClick(e: MouseEvent): void {
			getAttackedByPlayer();
		}

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}	
}
