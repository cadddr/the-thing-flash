package rooms {
	
	import flash.display.MovieClip;
	import rooms.GeneratorRoomInterface;
	import rooms.Room;
	
	
	public class GenRoom extends Room implements GeneratorRoomInterface {
		
		public function GenRoom() {
			// constructor code
		}
		
		override public function getLightSwitch(): MovieClip {
			return lightSwitch;
		}
	}
	
}
