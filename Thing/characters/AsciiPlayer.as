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
	import flash.geom.Rectangle;
	import Utils;

	
	public class AsciiPlayer extends Player {
		
		const IDLE_FRAME = 17;
		const WALK_FRAME = 1;
		const WEAPON_FRAME = 18;

		public function AsciiPlayer(infectedRefusalProbability, spawnThing) {
			super(infectedRefusalProbability, spawnThing);
			unhighlightForInteraction();
			asciiSyringe.visible = false;
			asciiCharge.visible = false;
			asciiMarker.visible = true;
			gotoAndStop(IDLE_FRAME); // where walking animation stops
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
			if (GlobalState.activePlayer != this) {
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
			super.initializeAction();
			if (previousRoom) {
				previousRoom.unhighlightReachableRooms();
			}
			currentRoom.highlightReachableRooms();
		}

		override public function finalizeAction() {
			super.finalizeAction()
			if (previousRoom != null) {
				previousRoom.unhighlightReachableRooms();
			}
			currentRoom.unhighlightReachableRooms();

			unhighlightForInteraction();
			// stopWeaponAnimation(); // TODO: check if it was running
		}

		public function animateMoveTo(x:Number, y:Number) {
			if (camera != null) {
				camera.pinCameraToObject(this);
			}

			gotoAndPlay(WALK_FRAME);
			var caller = this;
			var updateLighting = function(e:TweenEvent) {
				if (caller.previousRoom) {
					AsciiRoomBase(caller.previousRoom).applyTileLightingFromSource(caller.previousRoom, caller.x, caller.y)
				}
				AsciiRoomBase(caller.currentRoom).applyTileLightingFromSource(caller.currentRoom, caller.x, caller.y)
			}
			
			// var dy = previousRoom.y - currentRoom.y
			// if (Math.abs(dy) <= 40.25) {
			// 	trace('equivertical')
			// }
			// else if (dy > 0) {
			// 	trace('new room above')
			// 	var commonY = currentRoom.y + currentRoom.height;
			// } 
			// else if (dy < 0) {
			// 	trace('new room below')
			// 	var commonY = previousRoom.y + previousRoom.height
			// }

			// var dx = previousRoom.x - currentRoom.x
			// if (Math.abs(dx) <= 25.) {
			// 	trace('equihorizontal')
			// }
			// else if (dx > 0) {
			// 	trace('new room left')
			// 	var commonX = currentRoom.x + currentRoom.width;
			// } 
			// else if (dx < 0) {
			// 	trace('new room right')
			// 	var commonX = previousRoom.x + previousRoom.width;
			// }

			var corner1 = new Point(this.x, y);
			var corner2 = new Point(x, this.y);

			var rect1 = new Rectangle(previousRoom.x, previousRoom.y, previousRoom.width, previousRoom.height)
			var rect2 = new Rectangle(currentRoom.x, currentRoom.y, currentRoom.width, currentRoom.height)

			if (rect1.contains(corner1.x, corner1.y) || rect2.contains(corner1.x, corner1.y)) {
				var commonX = corner1.x;
				var commonY = corner1.y;
			}
			else //if (rect1.contains(corner2.x, corner2.y) || rect2.contains(corner2.x, corner2.y)) 
			{
				var commonX = corner2.x;
				var commonY = corner2.y;
			}
			if (GlobalState.DEBUG) {
				var mySprite:Shape = new Shape(); 
				mySprite.graphics.lineStyle(2, 0x990000, .75);
				// trajectory that will be tweened
				mySprite.graphics.moveTo(this.x, this.y);
				mySprite.graphics.cubicCurveTo(commonX, commonY, commonX, commonY, x, y);
				// box containing both points
				mySprite.graphics.drawRect(Math.min(this.x, x), Math.min(this.y, y), Math.abs(this.x - x), Math.abs(this.y - y)); 
				// show corners
				mySprite.graphics.beginFill(0xFFCC00); 
				mySprite.graphics.drawCircle(previousRoom.x, previousRoom.y, 5); 
				mySprite.graphics.drawCircle(previousRoom.x + previousRoom.width, previousRoom.y, 5); 
				mySprite.graphics.drawCircle(previousRoom.x, previousRoom.y + previousRoom.height, 5); 
				mySprite.graphics.drawCircle(previousRoom.x + previousRoom.width, previousRoom.y + previousRoom.height, 5); 
				mySprite.graphics.endFill(); 
				cameraLayer.addChild(mySprite);
			}

			// quadratic
			var trajectory = new BezierSegment(new Point(this.x, this.y), new Point(commonX, commonY), new Point(commonX, commonY), new Point(x, y));
            var dist = Math.sqrt((x - this.x) * (x - this.x) + (y - this.y) * (y - this.y)) / Math.sqrt(40.25 * 40.25 + 25 * 25);
        
			Utils.tweenValueAndFinish({"x": 0}, "x", None.easeNone, 0, 1, dist / 2.5, 
				function (e:TweenEvent) {
					var p = trajectory.getValue(e.position);
					// var angle = Math.atan((p.y - caller.y) / (p.x - caller.x))
					// caller.transform.matrix.translate((caller.x * caller.width/2), (caller.y + caller.height/2));
					// caller.rotation = 180. * angle / Math.PI - 90;
					// caller.transform.matrix.translate(-(caller.x * caller.width/2), -(caller.y + caller.height/2));
					// if (Math.abs(p.x - caller.x) >= 25.|| Math.abs(p.y - caller.y) >= 40.25) {
						caller.x = p.x;
						caller.y = p.y;
						updateLighting(e);
					// }
				},
				function(e:TweenEvent) {
					trace ('tween finished')
					caller.gotoAndStop(IDLE_FRAME);
					Utils.currentTween = null;
				}
			);
		}	
		public function weaponAnimation(targetX, targetY) {
			gotoAndPlay(WEAPON_FRAME);

			targetX = targetX - currentRoom.x
			targetY = targetY - currentRoom.y
			var thisX = x - currentRoom.x;
			var thisY = y - currentRoom.y;

			var projectile = new Spark();
			projectile.x = thisX;
			projectile.y = thisY;

			var slope = (targetY - thisY) / (targetX - thisX);
			var inter = thisY - slope * thisX;
			currentRoom.addChild(projectile);
			var caller = this;
			Utils.tweenValueAndFinish(projectile, "x", None.easeNone, thisX, targetX, .25,
				function (e:*) {
					projectile.y = e.position * slope + inter;
					caller.currentRoom.applyTileLightingFromSource(caller.currentRoom, caller.currentRoom.x + projectile.x, caller.currentRoom.y + projectile.y)
				},
				function (e:*) {
					caller.currentRoom.removeChild(projectile);
					
					// var explosion = new SparkExplosion();
					// explosion.x = targetX;
					// explosion.y = targetY;
					// caller.currentRoom.addChild(explosion);
					// explosion.gotoAndPlay(1);

					// caller.currentRoom.setFloorBackgroundColor(10.)
					// caller.currentRoom.removeChild(explosion);
					// caller.currentRoom.applyTileLightingFromSource(caller.currentRoom, 0, 0);
				});
		}
		public function stopWeaponAnimation() {
			gotoAndStop(IDLE_FRAME);
		}

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}
}
