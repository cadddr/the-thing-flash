package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.geom.Rectangle;
	
	public class Player extends MovieClip {
		
		
		public function Player() {
			// constructor code
			addEventListener(MouseEvent.MOUSE_DOWN, monMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, monMouseUp);
		}
		
		function monMouseDown(e:MouseEvent)
		{
			startDrag(false,new Rectangle(222,50,563,490));
		}
		
		function monMouseUp(e:MouseEvent)
		{
			stopDrag();
		}
	}
	
}
