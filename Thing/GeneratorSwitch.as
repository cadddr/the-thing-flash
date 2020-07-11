package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import fl.motion.MotionEvent;
	import GlobalState;
	import GenRoom;
	public class GeneratorSwitch extends MovieClip {
		
		
		public function GeneratorSwitch() 
		{
			this.addEventListener(MouseEvent.MOUSE_OVER, highlight);
			this.addEventListener(MouseEvent.MOUSE_OUT, unhighlight);
			
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			myselection.visible = false;
			myselection.gotoAndStop(1);
		}
		
		private function highlight(e:MouseEvent)
		{
			if(GlobalState.draggableCharacter 
			   && GlobalState.draggableCharacter.currentRoom is GenRoom)
				{
					myselection.gotoAndPlay(1);
					myselection.visible = true;
				}
		}
		
		private function unhighlight(e:MouseEvent)
		{
			myselection.gotoAndStop(1);
			myselection.visible = false;
		}
		
		private function onMouseUp(e:MouseEvent)
		{
			if(GlobalState.draggableCharacter)
				   if(GlobalState.draggableCharacter.currentRoom is GenRoom)
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
			   this.myselection.visible = false;
			   this.myselection.gotoAndStop(1);
		}
	}
	
}
