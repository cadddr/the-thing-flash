package items {
	

	import items.GeneratorSwitchBase
	import flash.events.Event;
	
	public class GeneratorSwitch extends GeneratorSwitchBase {
		
		
		public function GeneratorSwitch() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				myselection = mySquareSelection;
			});
		}
	}
	
}
