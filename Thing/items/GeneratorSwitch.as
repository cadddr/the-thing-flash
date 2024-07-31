package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import rooms.*
	import characters.Interactable;
	import asciiRooms.AsciiRoomBase
	
	public class GeneratorSwitch extends Interactable {
		// TODO: support multiple switches in a chain
		public function GeneratorSwitch() 
		{
			unhighlightForInteraction();
		}
		
		// TODO: rename as generic interact
		public function switchPower()
		{			
			   trace("Light has been switched to", GlobalState.isLightOn ? "on": "off");
			   GlobalState.isLightOn = !GlobalState.isLightOn;
			   dispatchEvent(new Event(GlobalState.LIGHT_SWITCHED));
		}
	}	
}
