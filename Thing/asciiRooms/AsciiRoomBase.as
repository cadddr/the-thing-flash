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
	import rooms.RoomBase;
	import flash.events.Event;
	import events.CharacterEvent;
	
	
	public class AsciiRoomBase extends RoomBase {
		var tileWidth = 25;
		var tileHeight = 40.25;
		
		public function AsciiRoomBase() {
			addEventListener(MouseEvent.MOUSE_MOVE, interactOnMouseMove);
			addEventListener(GlobalState.ROOM_BECAME_REACHABLE, function(e:Event): void {highlightReachable();});
			addEventListener(GlobalState.ROOM_BECAME_UNREACHABLE, function(e:Event): void {unhighlight();});
			addEventListener(GlobalState.CHARACTER_PLACED_IN_ROOM, function(e:CharacterEvent): void {putIn(e.character);});
		}

		public function spawnLightSwitch(cameraLayer: MovieClip, callback: Function): void {
			var lightSwitch: MovieClip = new AsciiGeneratorSwitch();
			
			lightSwitch.addEventListener(GlobalState.LIGHT_SWITCHED, callback);

			this.setLightSwitch(lightSwitch);

			lightSwitch.x = this.x + this.width / 2;
			lightSwitch.y = this.y + this.height / 2;
			cameraLayer.addChild(lightSwitch)
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

		public function applyTileLightingFromSource(container: MovieClip, x: Number, y: Number, on: Boolean = true): void {
			for(var i:int = 0; i < container.numChildren; i++) {
				var child = container.getChildAt(i);
				if (child is AsciiFloorTile) {
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

		public function putIn(character: Character): void {
			var position: Point = computePositionInRoom(character.x != 0 ? mouseX : 0, 
														character.y != 0 ? mouseY : 0, 
														character.width, 
														character.height);
			trace ('position in room', position);

			character.moveTo(position.x, position.y);
		}
		
		protected function computePositionInRoom(whomX: Number, whomY: Number, whomW: Number, whomH: Number): Point {
			return new Point(this.x + (Math.max(1, Math.floor(whomX / tileWidth) % Math.floor(width / tileWidth - .5))) * tileWidth, 
							 this.y + (Math.max(1, Math.floor(whomY / tileHeight) % Math.floor(height / tileHeight - .5))) * tileHeight);
		}

		override protected function interactOnMouseUp(event: MouseEvent): void {

		}

		//undrags the player and puts it into the room
		override protected function interactOnMouseClick(event: MouseEvent): void {
			if (IsReachable) {
				if (GlobalState.draggableCharacter != null) {
					//room logic
					register(GlobalState.draggableCharacter);
					//room view
					//mouse pos is relative to room on camera layer
					// putIn(GlobalState.draggableCharacter, mouseX, mouseY);
					//character logic & view
					GlobalState.draggableCharacter.finalizeAction();
				}
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

		protected function interactOnMouseMove(e:MouseEvent): void {
			// applyTileLightingFromSource(this, e.stageX, e.stageY);
			// applyTileLightingFromSource(this, mouseX, mouseY);
		}

		override protected function interactOnMouseOut(e:MouseEvent): void {
			// applyTileLightingFromSource(this, e.stageX, e.stageY, false);
			if (GlobalState.draggableCharacter) {
				if (IsReachable) {
					highlightReachable();
				} else {
					unhighlight();
				}
			}
		}

		public function unhighlight() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 31, 64, 104));
		}

		public function highlightSelected() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 81, 152, 114));
		}

		public function highlightReachable() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 242, 175, 101));
		}

		public function highlightRestricted() {
			setFloorColorTransform(new ColorTransform(0, 0, 0, 1, 228, 63, 90));
		}

		protected function setFloorColorTransform(colorTransform: ColorTransform) {
			for(var i:int = 0; i < numChildren; i++) {
				var child = getChildAt(i);
				if (child is AsciiFloorTile ) {
					child.asciiTileText.textColor = colorTransform.color;
				}
			}
		}
	}
}
