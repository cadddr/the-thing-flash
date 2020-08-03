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
	import fl.Layer;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	
	public class AsciiRoomBase extends Room {
		var tileWidth = 25;
		var tileHeight = 40.25;
		
		public function AsciiRoomBase() {

			addEventListener(MouseEvent.MOUSE_MOVE, interactOnMouseMove);
		}

		public function allocateChildrenToLayers(container: MovieClip, cameraLayer1: MovieClip, cameraLayer2: MovieClip): void {
			var children = new Array();
			for(var i:int = 0; i < container.numChildren; i++) {
				var child = container.getChildAt(i);
				if (child is AsciiWallTile ) {
					children.push(child);
				}
			}
			for each(var child:DisplayObject in children)
			{
				cameraLayer2.addChild(child);
				//offset by room position
				child.x += x;
				child.y += y;
			}
		}

        protected function getFloor(): MovieClip {
            return null;
        }

		public function applyTileLightingFromSource(container: MovieClip, x: Number, y: Number, on: Boolean = true): void {
			for(var i:int = 0; i < container.numChildren; i++) {
				var child = container.getChildAt(i);
				if (child is AsciiTile) {
					if (on == true) {
						child.applyLighting(x, y);
					}
					else {
						child.unapplyLighting();
					}
				}
				else if (child is MovieClip) {
					applyTileLightingFromSource(child, x, y, on);
				}
			}
		}

		protected function interactOnMouseMove(e:MouseEvent): void {
			applyTileLightingFromSource(this, e.stageX, e.stageY);
		}

		override protected function interactOnMouseOut(e:MouseEvent): void {
			applyTileLightingFromSource(this, e.stageX, e.stageY, false);
		}
		
		override protected function computePositionInRoom(whomX: Number, whomY: Number, whomW: Number, whomH: Number): Array {
			// if (whomX - this.x < tileWidth || whomY - this.y < tileHeight) {
			// 	whomX = this.x + tileWidth + Math.floor(Math.random() * (this.width - 2 * tileWidth));
			// 	whomY = this.y + tileHeight + Math.floor(Math.random() * (this.height - 2 * tileHeight));
			// }
			
			//this assumes room positions are snapped to tile grid
			// return [whomX - whomX % tileWidth, whomY - whomY % tileHeight];
			return [this.x + whomX - whomX % tileWidth, this.y + whomY - whomY % tileHeight];
		}

		override protected function interactOnMouseUp(event: MouseEvent): void {}

		//undrags the player and puts it into the room
		override protected function interactOnMouseClick(event: MouseEvent): void {
			if (IsReachable) {
				var draggableCharacter = GlobalState.draggableCharacter;

				if (draggableCharacter != null) {
					draggableCharacter.finalizeAction();
					//mouse pos is relative to room on camera layer
					putIn(draggableCharacter, mouseX, mouseY);

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
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 31, 64, 104));
		}

		override public function highlightSelected() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 255, 255, 255));
		}

		override public function highlightReachable() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 242, 175, 101));
		}

		override public function highlightRestricted() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 228, 63, 90));
		}

		protected function setFloorColorTransform(colorTransform: ColorTransform) {
			for(var i:int = 0; i < numChildren; i++) {
				var child = getChildAt(i);
				if (child is AsciiFloorTile ) {
					child.transform.colorTransform = colorTransform;
				}
			}
		}
	}
}
