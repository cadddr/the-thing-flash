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
			
		}
		
		private function highlight(e:MouseEvent)
		{
		}
		
		private function unhighlight(e:MouseEvent)
		{}
		
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
			   
			   GlobalState.things.forEach(function(item:*) {item.refreshVisibility()});  
		}
	}
	
}
