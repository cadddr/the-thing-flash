package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import GlobalState;
	
	
	public class AsciiFloorTile extends AsciiTile{
		var albedo = GlobalState.DARK_PURPLE;
		public var ambient = 1;
		
		
		public function AsciiFloorTile() {
			asciiTileText.background = true;
			// asciiTileText.mouseEnabled = false;
			asciiTileText.backgroundColor = albedo;
		}

		override protected function highlightForInteraction(): void {
            // asciiTileText.backgroundColor = GlobalState.BRIGHT_ORANGE;
        }
        override protected function unhighlightForInteraction(): void {
            // asciiTileText.backgroundColor = GlobalState.DARK_PURPLE;
        }

        public function applyLighting(sourceX, sourceY) {            
            var kd = 1;//0.0025
            var dist = getDistanceFrom(sourceX, sourceY);
            var diffuse = Math.cos(Math.atan(dist + 5));

			var albedoRgba = new Color();
			albedoRgba.tintColor = albedo;
			albedoRgba.tintMultiplier = ambient;
			// trace(albedoRgba.redOffset, albedoRgba.greenOffset, albedoRgba.blueOffset)
            asciiTileText.backgroundColor = albedo * ambient; //new ColorTransform(0,0,0,1,
                // albedoRgba.redOffset+(255-albedoRgba.redOffset)*diffuse,
                // albedoRgba.greenOffset+(255-albedoRgba.greenOffset)*diffuse,
                // albedoRgba.blueOffset+(255-albedoRgba.blueOffset)*diffuse,1).color;
		}

        public function unapplyLighting() {
            // asciiTileText.backgroundColor = albedo * ambient; //new ColorTransform(0, 0, 0, 1, 31, 64, 104, 1).color;
        }
	}
}
