package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import rooms.*
	
	public class GeneratorSwitch extends MovieClip {
		
		
		public function GeneratorSwitch() 
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			this.addEventListener(MouseEvent.MOUSE_OUT, unhighlight);
			
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			getSelection().visible = false;
			getSelection().gotoAndStop(1);
		}
		
		protected function getSelection(): MovieClip {
			return myselection;
		}
		
		private function highlight(e:MouseEvent)
		{
			if(GlobalState.draggableCharacter 
			   && GlobalState.draggableCharacter.currentRoom is GeneratorRoomInterface)
				{
					getSelection().gotoAndPlay(1);
					getSelection().visible = true;
				}
		}
		
		private function unhighlight(e:MouseEvent)
		{
			getSelection().gotoAndStop(1);
			getSelection().visible = false;
		}
		
		private function onMouseUp(e:MouseEvent)
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
			   stage.color = int(switchOn) * 0xffffff;
		
			   dispatchEvent(new Event("lightSwitched"));
			   
			   this.gotoAndStop(switchOn ? 1 : 2);
			
			   getSelection().visible = false;
			   getSelection().gotoAndStop(1);
		}
	}
	
}
