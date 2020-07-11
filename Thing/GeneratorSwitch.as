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
			
			this.addEventListener(MouseEvent.MOUSE_UP, switchPower);
			
		}
		
		private function highlight(e:MouseEvent)
		{
		}
		
		private function unhighlight(e:MouseEvent)
		{}
		
		private function switchPower(e:MouseEvent)
		{
			if(GlobalState.draggableCharacter)
				   if(GlobalState.draggableCharacter.currentRoom is GenRoom)
				   {
					   GlobalState.isLightOn = false;
					   stage.color = 0;
					   
					   GlobalState.things.forEach(function(item:*) {item.refreshVisibility()});
					   
					   GlobalState.draggableCharacter.finalizeAction();
				   }
		}
	}
	
}
