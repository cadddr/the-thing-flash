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

		override protected function interactOnMouseUp(e: MouseEvent): void {}

		override protected function interactOnMouseClick(e: MouseEvent): void {
			if(GlobalState.draggableCharacter)
				if(currentRoom == GlobalState.draggableCharacter.currentRoom)
				{	
					trace(GlobalState.draggableCharacter, "is attacking", this);
					
					//dice roll should be 2 or 1
					if(Utils.getRandom(6, 1) <= humanKillingProbability)
					{
						die();
					}
					else
						unhighlightForInteraction();
						
				// so he would knock off
				currentRoom.register(GlobalState.draggableCharacter as Player);
				GlobalState.draggableCharacter.finalizeAction();
			}
		}

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}	
}
