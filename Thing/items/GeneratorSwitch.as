package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import rooms.*
	import characters.Interactable;
	
	public class GeneratorSwitch extends Interactable {
		
		
		public function GeneratorSwitch() 
		{
			unhighlightForInteraction();
		}
		
		protected function getSelection(): MovieClip {
			return myselection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().gotoAndPlay(1);
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().visible = false;
			getSelection().gotoAndStop(1);
		}
		
		override protected function interactOnMouseOver(e:MouseEvent): void
		{
			if(GlobalState.draggableCharacter 
			   && GlobalState.draggableCharacter.currentRoom is GeneratorRoomInterface)
				{
					highlightForInteraction();
				}
		}
		
		override protected function interactOnMouseOut(e:MouseEvent): void
		{
			unhighlightForInteraction();
		}
		
		override protected function interactOnMouseUp(e:MouseEvent): void
		{
			if(GlobalState.draggableCharacter)
				   if(GlobalState.draggableCharacter.currentRoom is GeneratorRoomInterface)
				   {
					   switchPower(true);
					   GlobalState.draggableCharacter.finalizeAction();
				   }
		}
		
		public function switchPower(switchOn:Boolean)
		{			
			   trace("Light has been switched to", switchOn ? "on": "off");
			   GlobalState.isLightOn = switchOn;
			   stage.color = int(switchOn) * 0x1b1b2f;
		
			   dispatchEvent(new Event("lightSwitched"));
			   
			   this.gotoAndStop(switchOn ? 1 : 2);
			
			   unhighlightForInteraction();
		}
	}
	
}
