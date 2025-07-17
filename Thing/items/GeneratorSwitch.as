package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import rooms.*
	import characters.Interactable;
	import asciiRooms.AsciiRoomBase;
	import events.LightswitchEvent;
	import characters.Character;
	import GlobalState;
	
	public class GeneratorSwitch extends Interactable {
		// TODO: support multiple switches in a chain
		public function GeneratorSwitch() 
		{
			unhighlightForInteraction();
		}
		
		// TODO: rename as generic interact
		public function switchPower(character: Character)
		{			
			GlobalState.isLightOn = !GlobalState.isLightOn;
			trace("Light has been switched to", GlobalState.isLightOn ? "on": "off");   
			dispatchEvent(new LightswitchEvent(GlobalState.LIGHT_SWITCHED, GlobalState.isLightOn, character));
		}
	}	
}
