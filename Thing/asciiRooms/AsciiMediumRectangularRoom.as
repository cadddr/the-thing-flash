package asciiRooms {
	
	import flash.display.MovieClip;
	
	
	public class AsciiMediumRectangularRoom extends AsciiRoomBase {
		
		
		public function AsciiMediumRectangularRoom() {
			// constructor code
		}

		override protected function getFloor(): MovieClip {
            return asciiFloor;
    }
	}
	
}
