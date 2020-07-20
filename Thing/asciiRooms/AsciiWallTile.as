package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	
	public class AsciiWallTile extends AsciiTile {
		
		public function AsciiWallTile() {
		}

		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}
	}
}
