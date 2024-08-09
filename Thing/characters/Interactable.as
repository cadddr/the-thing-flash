package characters {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import fl.transitions.Tween;
	
	public class Interactable extends MovieClip {

		public function Interactable() {
			mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OVER, function (e: *) {
				// trace('over'); trace(e.localX); trace(e.localY); trace(e.target); trace(e.target.getBounds(e.target.parent)); 
				interactOnMouseOver(e); 
				e.stopPropagation();
			});
			addEventListener(MouseEvent.ROLL_OUT, function (e: *) {
				// trace('out'); trace(e.localX); trace(e.localY); trace(e.target); trace(e.target.getBounds(e.target.parent)); 
				interactOnMouseOut(e); 
				e.stopPropagation();
			});
			
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

		// used so that rooms made of other rooms don't trigger twice
		public function disableAllInteraction(): void {
			removeEventListener(MouseEvent.MOUSE_OVER, interactOnMouseOver);
			removeEventListener(MouseEvent.MOUSE_OUT, interactOnMouseOut);
			
			removeEventListener(MouseEvent.CLICK, interactOnMouseClick);
			removeEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);
			
			removeEventListener(MouseEvent.MOUSE_DOWN, interactOnMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, interactOnMouseUp);
		}

		// TODO: not used anywhere, remove?
		protected function canInteract(): Boolean {
			return false;
		}
	}	
}
