package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.*
	import flash.events.MouseEvent;
	
	public class AsciiGeneratorRoom extends AsciiSmallSquareRoom implements GeneratorRoomInterface {
		
		public function AsciiGeneratorRoom() {
			// asciiFloor = room.asciiFloor;
			room.disableAllInteraction();
		}
		
		public function getLightSwitch(): MovieClip {
			return asciiLightSwitch;
		}
	}
	
}
