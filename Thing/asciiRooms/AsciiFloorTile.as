package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	import flash.events.*;
	import flash.geom.ColorTransform;
	
	
	public class AsciiFloorTile extends AsciiTile{
		
		
		public function AsciiFloorTile() {
		}
		
		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}
		
	}
	
}
