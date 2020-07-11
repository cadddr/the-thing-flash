package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
	import Globals;
	
	public class Player extends MovieClip {		
		
		public function Player(playerName : String = "r") {			
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			// mouse up handled by stage
			
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, function() {gotoAndStop(2)});
			addEventListener(MouseEvent.MOUSE_OUT, function() {gotoAndStop(1)});
			
			this.transform.colorTransform = new ColorTransform(0, 0, 0, 1, Math.random() * 255, Math.random() * 255, Math.random() * 255);
		}
		
		function onMouseDown(e:MouseEvent)
		{
			startDrag();			
			mouseEnabled = false;
			Globals.draggableCharacter = this;			
		}
		
		
	}
	
}
