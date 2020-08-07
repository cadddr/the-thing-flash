package items {
	
	import flash.display.MovieClip;
	import items.*
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import GlobalState;
	import characters.*;
	
	
	public class AsciiExplosiveCharge extends ExplosiveCharge {
		
		
		public function AsciiExplosiveCharge() {
			// constructor code
		}

		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function interactOnMouseDown(e:MouseEvent): void {}
		override protected function interactOnMouseUp(e:MouseEvent): void {}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().visible = false;
		}


		override protected function interactOnMouseOver(e:MouseEvent): void
		{
				highlightForInteraction();
		}
		
		override protected function interactOnMouseClick(e:MouseEvent): void
		{			
			//explode
			if(isCharged && GlobalState.draggableCharacter != null)
			{
				GlobalState.draggableCharacter.currentRoom.register(GlobalState.draggableCharacter as Player);
				GlobalState.draggableCharacter.finalizeAction();
				
				GlobalState.plantedCharges.forEach(function(charge:*) {charge.explode()})
				GlobalState.plantedCharges = [];
				return;
			}

			if(!owner.IsInactive)
			{
				trace(owner, "has planted explosive charge in", owner.currentRoom);				
				this.visible = false;
				//todo: detach from owner rather than creating new instance
				var plantedCharge = new AsciiExplosiveCharge();
				plantedCharge.x = owner.x;
				plantedCharge.y = owner.y;
				plantedCharge.visible = true;
				plantedCharge.isCharged = true;
				plantedCharge.currentRoom = owner.currentRoom;
				
				stage.addChild(plantedCharge);
				GlobalState.plantedCharges.push(plantedCharge);
			
				owner.finalizeAction();
			}
		}

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}
	
}
