package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import rooms.*;
	import items.GeneratorSwitch
	
	
	public class AsciiGeneratorSwitch extends GeneratorSwitch {
		
		public function AsciiGeneratorSwitch() {
		}
		
		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}
		
	}
	
}
