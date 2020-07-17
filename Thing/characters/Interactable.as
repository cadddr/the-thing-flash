package characters {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Interactable extends MovieClip {

		public function Interactable() {
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			
			addEventListener(MouseEvent.CLICK, onMouseClick);
			addEventListener(MouseEvent.RIGHT_CLICK, onMouseRightClick);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		protected function onMouseOver(e:MouseEvent) {}
		protected function onMouseOut(e:MouseEvent) {}
		
		protected function onMouseClick(e:MouseEvent) {}
		protected function onMouseRightClick(e:MouseEvent) {}
		
		protected function onMouseDown(e:MouseEvent) {}
		protected function onMouseUp(e:MouseEvent) {}

	}	
}
