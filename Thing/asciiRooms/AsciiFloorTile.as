package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import GlobalState;
	
	
	public class AsciiFloorTile extends AsciiTile{
		
		
		public function AsciiFloorTile() {
			asciiTileText.background = false;
			asciiTileText.mouseEnabled = false;
			asciiTileText.backgroundColor = GlobalState.DARK_PURPLE;
		}
		
		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
            asciiTileText.backgroundColor = GlobalState.BRIGHT_ORANGE;
        }
        override protected function unhighlightForInteraction(): void {
            asciiTileText.backgroundColor = GlobalState.DARK_PURPLE;
        }
		
	}
}
