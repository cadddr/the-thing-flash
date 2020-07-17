package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.Room;
	import characters.*;
	import flash.events.*;
	import items.AsciiGeneratorSwitch;
	
	
	public class AsciiSmallSquareRoom extends Room {
		
		public function AsciiSmallSquareRoom() {
		}
		
		override protected function computePositionInRoom(whom: Character): Array {
			return [x + 25, y + 40.25];
		}
	}
	
}
