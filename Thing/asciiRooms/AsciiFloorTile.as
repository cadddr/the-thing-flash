package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	import flash.events.*;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import GlobalState;
	
	public class AsciiFloorTile extends AsciiTile{
		var albedo = GlobalState.DARK_PURPLE;

		public var ambient = 1.;
		public function set Ambient(value: Number) {		
			ambient = value;
	
			var albedoRgba = new Color();
			albedoRgba.tintColor = albedo;
			albedoRgba.tintMultiplier = ambient;
			
			asciiTileText.backgroundColor = new ColorTransform(0,0,0,1,
                albedoRgba.redOffset,
                albedoRgba.greenOffset,
                albedoRgba.blueOffset
			).color;
		}
		
		
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

		var maxDist = 25. //tileWidth
        public function applyLighting(sourceX, sourceY) {            
            var kd = 0.25 + (1. - ambient) // double character light intensity during blackout
            var dist = getDistanceFrom(sourceX, sourceY);
            var diffuse = Math.exp(-dist / maxDist);

			var albedoRgba = new Color();
			albedoRgba.tintColor = albedo;
			albedoRgba.tintMultiplier = ambient;

			var D = function (x) {
				return x + (255 - x) * diffuse * kd;
			}
			
            asciiTileText.backgroundColor = 
				new ColorTransform(0,0,0,1,D(albedoRgba.redOffset),D(albedoRgba.greenOffset), D(albedoRgba.blueOffset),1).color;
		}

        public function unapplyLighting() {
            // asciiTileText.backgroundColor = albedo * ambient; //new ColorTransform(0, 0, 0, 1, 31, 64, 104, 1).color;
        }
	}
}
