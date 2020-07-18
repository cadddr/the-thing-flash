package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	
	
	public class AsciiFloorTile extends AsciiTile{
		
		
		public function AsciiFloorTile() {
			// constructor code
		}
		
		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}
		
		
	}
	
}
