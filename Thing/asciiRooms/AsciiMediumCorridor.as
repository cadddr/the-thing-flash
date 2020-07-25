package asciiRooms {
	
	import flash.display.MovieClip;
	
	
	public class AsciiMediumCorridor extends AsciiRoomBase {
		
		
		public function AsciiMediumCorridor() {
			// constructor code
		}

		override protected function getFloor(): MovieClip {
            return asciiFloor;
    }
	}
	
}
