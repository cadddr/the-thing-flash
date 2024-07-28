package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import rooms.*
	import characters.Interactable;
	import asciiRooms.AsciiRoomBase
	
	public class GeneratorSwitch extends Interactable {
		
		
		public function GeneratorSwitch() 
		{
			unhighlightForInteraction();
		}
		
		protected function getSelection(): MovieClip {
			throw null;
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
			   && GlobalState.draggableCharacter.currentRoom.interactables.indexOf(this) != -1)
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
				   if(GlobalState.draggableCharacter.currentRoom.interactables.indexOf(this) != -1)
				   {
					   switchPower();
					   GlobalState.draggableCharacter.finalizeAction();
				   }
		}
		
		public function switchPower()
		{			
			   GlobalState.isLightOn = !GlobalState.isLightOn;
			   trace("Light has been switched to", GlobalState.isLightOn ? "on": "off");
			   AsciiRoomBase(GlobalState.draggableCharacter.currentRoom).setFloorBackgroundColor(int(GlobalState.isLightOn))// * 0x1b1b2f);
		
			   dispatchEvent(new Event(GlobalState.LIGHT_SWITCHED));
			   
			   this.gotoAndStop(GlobalState.isLightOn ? 1 : 2);
			
			   unhighlightForInteraction();
		}
	}
	
}
