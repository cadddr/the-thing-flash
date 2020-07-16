package items {
	
	import flash.display.MovieClip;
	import items.GeneratorSwitchBase
	import flash.events.Event;
	
	
	public class AsciiGeneratorSwitch extends GeneratorSwitchBase {
		
		public function AsciiGeneratorSwitch() {
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				this.myselection = asciiSelection;
			});
			
		}
	}
	
}
