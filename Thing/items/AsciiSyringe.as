package items {
	
	import items.*;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import characters.*;
	
	
	public class AsciiSyringe extends Syringe {
		
		
		public function AsciiSyringe() {
			unhighlightForInteraction();
			visible = false;
		}

		protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().visible = false;
		}

		override protected function interactOnMouseOver(e:MouseEvent): void
		{
				highlightForInteraction();
		}

		override protected function interactOnMouseOut(e:MouseEvent): void
		{
			unhighlightForInteraction();
		}

		protected function dieAnimation()
		{
			this.visible = false;
		}

	}
	
}
