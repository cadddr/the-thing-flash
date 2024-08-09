package asciiRooms {
	
	import flash.display.MovieClip;
	import asciiRooms.AsciiTile;
	import flash.events.*;
	import GlobalState;
	import Utils;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	import Utils;
	
	public class AsciiFloorTile extends AsciiTile{
		var albedo = GlobalState.DARK_PURPLE;

		public var ambient = 1.;
		
		public function set Ambient(value: Number) {		
			// ambient = value;
			Utils.tweenValue(this, "ambient", None.easeNone, this.ambient, value, 0.5, function(e:TweenEvent) {
				asciiTileText.backgroundColor = Utils.scaleColor(albedo, e.position);
			});
			// asciiTileText.backgroundColor = Utils.scaleColor(albedo, ambient);
		}
		
		public function AsciiFloorTile() {
			asciiTileText.background = true;
			asciiTileText.mouseEnabled = false;
			asciiTileText.backgroundColor = albedo;
		}

		override protected function highlightForInteraction(): void {
            // asciiTileText.backgroundColor = GlobalState.BRIGHT_ORANGE;
        }
        override protected function unhighlightForInteraction(): void {
            // asciiTileText.backgroundColor = GlobalState.DARK_PURPLE;
        }
		override protected function interactOnMouseClick(e:MouseEvent): void {
			var caller = this;
			var origAmbient = ambient;
			// asciiTileText.backgroundColor = GlobalState.BRIGHT_ORANGE
			Utils.tweenValueAndFinish(this, "ambient", None.easeNone, 10., origAmbient, 1., 
				function (e:*) {},
				function (e:*) {
					caller.ambient = origAmbient;
					caller.asciiTileText.backgroundColor = Utils.scaleColor(caller.albedo, caller.ambient);
				}
			);
		}

		var maxDist = 25. //tileWidth
        public function applyLighting(sourceX, sourceY) {            
            var kd = 0.25 + (1. - ambient) // double character light intensity during blackout
            var dist = getDistanceFrom(sourceX, sourceY);
            var diffuse = Math.exp(-dist / maxDist);

			// TODO: interpolate?
            asciiTileText.backgroundColor = Utils.scaleTransformColor(albedo, ambient, 
				function (x) {
					return x + (255 - x) * diffuse * kd;
				});
			}

        public function unapplyLighting() {
            // asciiTileText.backgroundColor = albedo * ambient; //new ColorTransform(0, 0, 0, 1, 31, 64, 104, 1).color;
        }
	}
}
