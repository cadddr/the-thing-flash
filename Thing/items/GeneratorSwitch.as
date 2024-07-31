package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import rooms.*
	import characters.Interactable;
	import asciiRooms.AsciiRoomBase
	import events.LightswitchEvent
	
	public class GeneratorSwitch extends Interactable {
		// TODO: support multiple switches in a chain
		public function GeneratorSwitch() 
		{
			unhighlightForInteraction();
		}
		
		// TODO: rename as generic interact
		public function switchPower()
		{			
			GlobalState.isLightOn = !GlobalState.isLightOn;
			trace("Light has been switched to", GlobalState.isLightOn ? "on": "off");   
			GlobalState.globalDispatchEvent(new LightswitchEvent(GlobalState.LIGHT_SWITCHED, GlobalState.isLightOn));
		}
	}	
}
