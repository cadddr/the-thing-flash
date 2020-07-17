package items {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	public class AsciiGeneratorSwitch extends MovieClip {
		
		public function AsciiGeneratorSwitch() {
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
			});
			
		}
		
		protected function getSelection(): MovieClip {
			return asciiSelection;
		}
	}
	
}
