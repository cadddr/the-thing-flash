package view {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class InteractableView extends MovieClip {

		public function InteractableView() {
			addEventListener(MouseEvent.MOUSE_OVER, interactOnMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, interactOnMouseOut);
			
			addEventListener(MouseEvent.CLICK, interactOnMouseClick);
			addEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);
			
			addEventListener(MouseEvent.MOUSE_DOWN, interactOnMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, interactOnMouseUp);
		}
		
		public function interactOnMouseOver(e:MouseEvent): void {}
		public function interactOnMouseOut(e:MouseEvent): void {}
		
		public function interactOnMouseClick(e:MouseEvent): void {}
		public function interactOnMouseRightClick(e:MouseEvent): void {}
		
		public function interactOnMouseDown(e:MouseEvent): void {}
		public function interactOnMouseUp(e:MouseEvent): void {}

		public function highlightForInteraction(): void {}
		public function unhighlightForInteraction(): void {}

		public function disableAllInteraction(): void {
			removeEventListener(MouseEvent.MOUSE_OVER, interactOnMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, interactOnMouseOut);
			
			removeEventListener(MouseEvent.CLICK, interactOnMouseClick);
			removeEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);
			
			removeEventListener(MouseEvent.MOUSE_DOWN, interactOnMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, interactOnMouseUp);
		}

	}	
}
