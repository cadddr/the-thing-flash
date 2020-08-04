package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import GlobalState;
	
	
	public class AsciiFloorTile extends AsciiTile{
		
		
		public function AsciiFloorTile() {
			asciiTileText.background = true;
			asciiTileText.backgroundColor = GlobalState.DARK_PURPLE;
		}
		
		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}
		
	}
	
}
