package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.Room;
	import characters.*;
	import flash.events.*;
	import items.AsciiGeneratorSwitch;
	import flash.geom.ColorTransform;
	import GlobalState;
	import asciiRooms.AsciiTile;
	import flash.events.MouseEvent;
	
	
	public class AsciiSmallSquareRoom extends Room {
		var tileWidth = 25;
		var tileHeight = 40.25;
		
		public function AsciiSmallSquareRoom() {
			var caller = this;
			addEventListener(MouseEvent.MOUSE_MOVE, function(e:MouseEvent) {
				trace("children")
				for(var i:int = 0; i < caller.numChildren; i++) {
					if (caller.getChildAt(i) is AsciiWallTile) {
						trace (caller.getChildAt(i).name, caller.getChildAt(i).toString(), caller.getChildAt(i)) 
						diffuse(caller.getChildAt(i), e);
					}
				}
			});
		}

		private function diffuse(child:MovieClip, e:MouseEvent) {
			trace("tile on mouseMove");
            var kd = 1;//0.0025
            var diffuse = 0.;
            var x = child.x - e.stageX;
            var y = child.y - e.stageY;
            var dist = Math.sqrt(x*x + y*y);
			trace ("dist", dist);
            diffuse += Math.cos(Math.atan(dist));
			diffuse *= 10;
			trace("diffuse", diffuse);
            child.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 
			diffuse*255,diffuse*255,diffuse*255);
        
		}
		
		override protected function computePositionInRoom(whom: Character): Array {
			if (whom.x - x < tileWidth || whom.y - y < tileHeight) {
				whom.x = x + tileWidth + Math.floor(Math.random() * (width - 2 * tileWidth));
				whom.y = y + tileHeight + Math.floor(Math.random() * (height - 2 * tileHeight));
			}
			
			//this assumes room positions are snapped to tile grid
			return [whom.x - whom.x % tileWidth, whom.y - whom.y % tileHeight];
		}

		override protected function interactOnMouseUp(event: MouseEvent): void {}

		//undrags the player and puts it into the room
		override protected function interactOnMouseClick(event: MouseEvent): void {
			trace("on mouse click", this);
			if (IsReachable) {
				var draggableCharacter = GlobalState.draggableCharacter;

				if (draggableCharacter != null) {
					draggableCharacter.finalizeAction();
					draggableCharacter.x = event.stageX
					draggableCharacter.y = event.stageY;
					putIn(draggableCharacter);

				}

				highlightReachableRooms(false);
			}
		}

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (GlobalState.draggableCharacter) {
				if (IsReachable) {
					highlightSelected();
				} else {
					highlightRestricted();
				}
			}
		}

		override public function unhighlight() {
			// asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 31, 64, 104);
		}

		override public function highlightSelected() {
			// asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 255, 255, 255);
		}

		override public function highlightReachable() {
			// asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 242, 175, 101);
		}

		override public function highlightRestricted() {
			// asciiFloor.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 228, 63, 90);
		}
	}
}
