package characters {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Interactable extends MovieClip {

		public function Interactable() {
			addEventListener(MouseEvent.MOUSE_OVER, interactOnMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, interactOnMouseOut);
			
			addEventListener(MouseEvent.CLICK, interactOnMouseClick);
			addEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);
			
			addEventListener(MouseEvent.MOUSE_DOWN, interactOnMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, interactOnMouseUp);
		}
		
		protected function interactOnMouseOver(e:MouseEvent): void {}
		protected function interactOnMouseOut(e:MouseEvent): void {}
		
		protected function interactOnMouseClick(e:MouseEvent): void {}
		protected function interactOnMouseRightClick(e:MouseEvent): void {}
		
		protected function interactOnMouseDown(e:MouseEvent): void {}
		protected function interactOnMouseUp(e:MouseEvent): void {}

		protected function highlightForInteraction(): void {}
		protected function unhighlightForInteraction(): void {}

		public function disableAllInteraction(): void {
			removeEventListener(MouseEvent.MOUSE_OVER, interactOnMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, interactOnMouseOut);
			
			removeEventListener(MouseEvent.CLICK, interactOnMouseClick);
			removeEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);
			
			removeEventListener(MouseEvent.MOUSE_DOWN, interactOnMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, interactOnMouseUp);
		}

		protected function canInteract(): Boolean {
			return false;
		}
	}	
}
