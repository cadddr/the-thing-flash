package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
	import Globals;
	
	public class Player extends MovieClip {
		
		
		public function Player(playerName : String = "r") {
			
			addEventListener(MouseEvent.MOUSE_DOWN, monMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, monMouseUp);
			
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, function() {gotoAndStop(2)});
			addEventListener(MouseEvent.MOUSE_OUT, function() {gotoAndStop(1)});
			
			this.playerName.text = playerName;
			this.transform.colorTransform = new ColorTransform(0, 0, 0, 1, Math.random() * 255, Math.random() * 255, Math.random() * 255);
		}
		
		
		
		function monMouseDown(e:MouseEvent)
		{
			startDrag(false, new Rectangle(222,50,563,490));
			//Globals.draggableCharacter = this;
			mouseEnabled = false;
		}
		
		function monMouseUp(e:MouseEvent)
		{
			stopDrag();
		}
	}
	
}
