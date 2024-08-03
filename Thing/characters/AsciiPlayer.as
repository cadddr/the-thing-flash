package characters {
	
	import characters.Player
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.geom.ColorTransform;
	import items.AsciiSyringe;
	import asciiRooms.AsciiRoomBase;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	import fl.motion.BezierSegment;
	import flash.geom.Point;
	import Utils;

	
	public class AsciiPlayer extends Player {
		
		public function AsciiPlayer(infectedRefusalProbability, spawnThing) {
			super(infectedRefusalProbability, spawnThing);
			unhighlightForInteraction();
			asciiSyringe.visible = false;
			asciiCharge.visible = false;
			asciiMarker.visible = true;
			gotoAndStop(24); // where walking animation stops
		}

		override public function getSyringe(): MovieClip {
			return asciiSyringe;
		}

		override public function getCharge(): MovieClip {
			return asciiCharge;
		}

		override protected function highlightForInteraction(): void {
			if (currentRoom != null) //TODO:
			{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y);}
		}

		override protected function unhighlightForInteraction(): void {
			if (GlobalState.draggableCharacter != this) {
				if (currentRoom != null) //TODO:
				{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y);}
			}
		}

		override protected function markAlreadyActed(): void {
			asciiMarker.visible = false
		}

		override protected function markReadyToAct(): void {
			asciiMarker.visible = true
		}

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (!AlreadyActed) {
				highlightForInteraction();
			}
		}

		override protected function interactOnMouseOut(e: MouseEvent): void {
			if (!AlreadyActed) {
				unhighlightForInteraction();
			}				
		}

		override protected function interactOnMouseClick(e: MouseEvent): void {
			attemptAction();
		}

		// TODO: this one inadvertedly circumvents order refusal check?
		// also no check for having acted?
		public function selectAsActiveCharacter(): void {
			highlightForInteraction();
			initializeAction();
		}

		public function unselectAsActiveCharacter(): void {
			unhighlightForInteraction();
		}

		override protected function initializeAction() {
			if (previousRoom) {
				previousRoom.unhighlightReachableRooms();
			}
			currentRoom.highlightReachableRooms();
			GlobalState.draggableCharacter = this;
		}

		override public function finalizeAction() {
			if (previousRoom != null) {
				previousRoom.unhighlightReachableRooms();
			}
			currentRoom.unhighlightReachableRooms();
			GlobalState.draggableCharacter = null;
			AlreadyActed = true;

			unhighlightForInteraction();
		}

		public function animateMoveTo(x:Number, y:Number) {
			if (camera != null) {
				camera.pinCameraToObject(this);
			}

			gotoAndPlay(1); // walk animation
			var caller = this;
			var updateLighting = function(e:TweenEvent) {
				if (caller.previousRoom) {
					AsciiRoomBase(caller.previousRoom).applyTileLightingFromSource(caller.previousRoom, caller.x, caller.y)
				}
				AsciiRoomBase(caller.currentRoom).applyTileLightingFromSource(caller.currentRoom, caller.x, caller.y)
			}
			var roundObject:Shape = new Shape(); 
			roundObject.graphics.lineStyle(2, 0x990000, .75);
			
			roundObject.graphics.moveTo(this.x, this.y);
			roundObject.graphics.cubicCurveTo(
					previousRoom.x + previousRoom.width / 2,
					previousRoom.y + previousRoom.height / 2,
					currentRoom.x + currentRoom.width / 2, 
					currentRoom.y + currentRoom.height / 2,
					x, y
			);
			cameraLayer.addChild(roundObject);

			var trajectory = new BezierSegment(
				new Point(this.x, this.y), 
				new Point(
					previousRoom.x + previousRoom.width / 2,
					previousRoom.y + previousRoom.height / 2), 
				new Point(
					currentRoom.x + currentRoom.width / 2, 
					currentRoom.y + currentRoom.height / 2),
				new Point(x, y));

			Utils.tweenValueAndFinish({"x": 0}, "x", None.easeNone, 0, 1, 1, 
				function (e:TweenEvent) {
					var p = trajectory.getValue(e.position);
					caller.x = p.x;
					caller.y = p.y;
				},
				function(e:TweenEvent) {caller.gotoAndStop(24);}
			// Utils.tweenValue(caller, "x", None.easeNone, caller.x, Math.max(x, minX), 1, updateLighting
				// function(e:TweenEvent) {
				// 	Utils.tweenValueAndFinish(caller, "y", None.easeNone, caller.y, y, 1, updateLighting,
				// 		function(e:TweenEvent) {caller.gotoAndStop(24);}
				// 	);
				// }
			);
		}	

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}
}
