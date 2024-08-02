package asciiRooms {
	
	import flash.display.MovieClip;
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
	import flash.display.Shape;
	import rooms.RoomBase;
	import flash.events.Event;
	import events.CharacterEvent;
	import events.LightswitchEvent;
	import characters.Interactable;
	
	//display specific functionality, UI interactions, positioning, animations
	public class AsciiRoomBase extends RoomBase {
		
		var tileWidth = 25;
		var tileHeight = 40.25;
		
		public function AsciiRoomBase() {
			addEventListener(GlobalState.CHARACTER_PLACED_IN_ROOM, function(e:CharacterEvent): void {positionInRoom(e.character);});
			GlobalState.addGlobalEventListener(GlobalState.LIGHT_SWITCHED, function (e:LightswitchEvent): void { 
				setFloorBackgroundColor(int(e.isLightOn));
			});
		}

		// and this is a different Interactable e.g., a generator switch or a planted charge
		public function spawnInteractable(interactable: Interactable, cameraLayer: MovieClip): void {
			interactables.push(interactable);


			var point = computePositionInRoom(Math.random() * width, Math.random() * height * tileHeight,0,0);
			interactable.x = point.x;
			interactable.y = point.y;
			cameraLayer.addChild(interactable)
		}

		// TODO: shouldn't it be applied at each tile' ENTER_FRAME?
		public function applyTileLightingFromSource(container: MovieClip, x: Number, y: Number): void {
			for(var i:int = 0; i < container.numChildren; i++) {
				var child = container.getChildAt(i);
				if (child is AsciiFloorTile) {
					child.applyLighting(x, y);
				}
				else if (child is MovieClip) {
					applyTileLightingFromSource(child, x, y);
				}
			}
		}

		public function positionInRoom(character: Character): void {
			var position: Point = computePositionInRoom(
				character.x != 0 ? mouseX : 0, 
				character.y != 0 ? mouseY : 0, 
				character.width, character.height
			);
			trace ('position in room', position);
			if (character.previousRoom != null && character is AsciiPlayer) {
				AsciiPlayer(character).animateMoveTo(position.x, position.y);
			}
			else {
				character.x = position.x;
				character.y = position.y;
			}
		}
		
		public function computePositionInRoom(whomX: Number, whomY: Number, whomW: Number, whomH: Number): Point {
			return new Point(this.x + (Math.max(1, Math.floor(whomX / tileWidth) % Math.floor(width / tileWidth - .5))) * tileWidth, 
							 this.y + (Math.max(1, Math.floor(whomY / tileHeight) % Math.floor(height / tileHeight - .5))) * tileHeight);
		}

		//undrags the player and puts it into the room
		override protected function interactOnMouseClick(event: MouseEvent): void {
			if (GlobalState.draggableCharacter != null) {
				if (isReachableFrom(GlobalState.draggableCharacter.currentRoom)) {
					register(GlobalState.draggableCharacter); //also raises event that positions char in room
					GlobalState.draggableCharacter.finalizeAction();
				}
			}
		}

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (GlobalState.draggableCharacter) {
				if (isReachableFrom(GlobalState.draggableCharacter.currentRoom)) {
					highlightSelected();
				} 
				else {
					highlightRestricted();
				}
			}
		}

		override protected function interactOnMouseOut(e:MouseEvent): void {
			if (GlobalState.draggableCharacter) {
				if (isReachableFrom(GlobalState.draggableCharacter.currentRoom)) {
					highlightReachable();
				} 
				else {
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

		override public function highlightReachableRooms(): void {
            for each(var room:* in accessibleRooms) {
                room.highlightReachable();
            }
		}

		override public function unhighlightReachableRooms(): void {
            for each(var room:* in accessibleRooms) {
                room.unhighlight();
            }
		}

		protected function setFloorColorTransform(colorTransform: ColorTransform) {
			for(var i:int = 0; i < numChildren; i++) {
				var child = getChildAt(i);
				if (child is AsciiFloorTile ) {
					child.asciiTileText.textColor = colorTransform.color;
				}
			}
		}

		public function setFloorBackgroundColor(color: int) {
			for(var i:int = 0; i < numChildren; i++) {
				var child = getChildAt(i);
				if (child is AsciiFloorTile ) {
					child.Ambient = color;
				}
			}
		}
	}
}
