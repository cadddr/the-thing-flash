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
	import flash.events.Event;
	
	public class AsciiPlayer extends Player {
		
		const IDLE_FRAME = 17;
		const WALK_FRAME = 1;
		const WALK_FRAME2 = 5;
		const WALK_FRAME3 = 9;
		const WALK_FRAME4 = 13;

		const WEAPON_FRAME = 18;

		public function AsciiPlayer(infectedRefusalProbability, spawnThing) {
			super(infectedRefusalProbability, spawnThing);
			unhighlightForInteraction();
			asciiSyringe.visible = false;
			asciiSyringe.mouseEnabled = false;
			asciiCharge.visible = false;
			asciiCharge.mouseEnabled = false;
			asciiMarker.visible = true;
			asciiMarker.mouseEnabled = false;
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
			{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x - GlobalState.TILE_WIDTH / 2, y - GlobalState.TILE_HEIGHT / 2);}
		}

		override protected function unhighlightForInteraction(): void {
			// if (GlobalState.activePlayer != this) {
			// 	if (currentRoom != null) //TODO:
			// 	{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, y);}
			// }
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
			if (GlobalState.activePlayer != null) {
				AsciiPlayer(GlobalState.activePlayer).unselectAsActiveCharacter()
			}
			selectAsActiveCharacter();
		}

		public function selectAsActiveCharacter(): void {
			trace ('select', this)
			highlightForInteraction();
			addEventListener(Event.ENTER_FRAME, trackMousePosition);
			attemptAction();
		}

		public function unselectAsActiveCharacter(): void {
			trace ('unselect', this)
			unhighlightForInteraction();
			removeEventListener(Event.ENTER_FRAME, trackMousePosition)
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

			unselectAsActiveCharacter();
			// stopWeaponAnimation(); // TODO: check if it was running
		}

		public function trackMousePosition(e:*) {
			var stageX = parent.x + x;
			var stageY = parent.y + y

			rotation = atan2(stage.mouseX, stage.mouseY, stageX, stageY)
		}

		public function atan2(x1, y1, x2, y2) {
			var dy = y2 - y1
			var dx = x2 - x1
			var angle;

			if (dx >= 0) {
				angle = Math.atan(dy / dx)
				return 180. * angle / Math.PI - 90
			}
			else {
				angle = Math.atan(dy / dx)
				return 180. * angle / Math.PI - 90 + 180
			}
		}
		

		public function animateMoveTo(x:Number, y:Number) {
			if (camera != null) {
				camera.pinCameraToObject(this);
			}
			removeEventListener(Event.ENTER_FRAME, trackMousePosition)

			var caller = this;
			var updateLighting = function(e:TweenEvent) {
				if (caller.previousRoom) {
					AsciiRoomBase(caller.previousRoom).applyTileLightingFromSource(caller.previousRoom, caller.x - GlobalState.TILE_WIDTH / 2, caller.y - GlobalState.TILE_HEIGHT / 2)
				}
				AsciiRoomBase(caller.currentRoom).applyTileLightingFromSource(caller.currentRoom, caller.x - GlobalState.TILE_WIDTH / 2, caller.y - GlobalState.TILE_HEIGHT / 2)
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

			var commonX, commonY;
			if (rect1.contains(corner1.x, corner1.y) || rect2.contains(corner1.x, corner1.y)) {
				commonX = corner1.x;
				commonY = corner1.y;
			}
			else //if (rect1.contains(corner2.x, corner2.y) || rect2.contains(corner2.x, corner2.y)) 
			{
				commonX = corner2.x;
				commonY = corner2.y;
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

			var totalLength:Number = Utils.bezierLength(trajectory);
			var tileSize:Number = Math.sqrt(GlobalState.TILE_HEIGHT * GlobalState.TILE_HEIGHT + GlobalState.TILE_WIDTH * GlobalState.TILE_WIDTH);
			var numSteps:int = Math.ceil(totalLength / tileSize);
			var stepValues = Utils.getTValuesForSteps(trajectory, numSteps, tileSize);

			gotoAndStop(WALK_FRAME);
			Utils.tweenValueSteppedAndFinish(stepValues, 0.35, 
				function(e:TweenEvent) {
					var p = trajectory.getValue(e.position);
					var p_ = trajectory.getValue(e.position + 0.01);
					var p__ = trajectory.getValue(e.position - 0.01);
					// var angle = Math.atan((p.y - caller.y) / (p.x - caller.x))
					rotation = atan2(p_.x, p_.y, p__.x, p__.y)
					// caller.rotation = 180. * angle / Math.PI// - 90;

					caller.x = p.x;
					caller.y = p.y;
					if (GlobalState.DEBUG) mySprite.graphics.drawCircle(p.x, p.y, 3); 
					updateLighting(e);
				}, 
				function (e:*) {
					// var p = trajectory.getValue(e.position);
	
			
					switch (currentFrame) {
						case WALK_FRAME: {
							gotoAndStop(WALK_FRAME3)
							break
						}
						// case WALK_FRAME2: {
						// 	gotoAndStop(WALK_FRAME3)
						// 	break
						// }
						case WALK_FRAME3: {
							gotoAndStop(WALK_FRAME)
							break
						}
						// case WALK_FRAME4: {
						// 	gotoAndStop(WALK_FRAME)
						// 	break
						// }
					}
				},
				function (e:*) {gotoAndStop(IDLE_FRAME)}
			);
			// Utils.tweenValueAndFinish({"x": 0}, "x", None.easeNone, 0, 1, dist / 2.5, 
			// 	function (e:TweenEvent) {
			// 		var p = trajectory.getValue(e.position);
					// caller.x = p.x;
					// caller.y = p.y;
					// updateLighting(e);
					// if (GlobalState.DEBUG) mySprite.graphics.drawCircle(p.x, p.y, 3); 
			// 		// }
			// 	},
			// 	function(e:TweenEvent) {
			// 		trace ('tween finished')
			// 		caller.gotoAndStop(IDLE_FRAME);
			// 		Utils.currentTween = null;
			// 	}
			// );
		}	

		public function weaponAnimation(targetX, targetY) {
			gotoAndPlay(WEAPON_FRAME);

			targetX = targetX - currentRoom.x + GlobalState.TILE_WIDTH / 2
			targetY = targetY - currentRoom.y + GlobalState.TILE_HEIGHT / 2
			var thisX = x - currentRoom.x;
			var thisY = y - currentRoom.y;

			var projectile = new Spark();
			projectile.x = thisX;
			projectile.y = thisY;

			var slope = (targetY - thisY) / (targetX - thisX);
			var inter = thisY - slope * thisX;
			currentRoom.addChild(projectile);
			var caller = this;
			Utils.tweenValueAndFinish(projectile, "x", Regular.easeOut, thisX, targetX, .15,
				function (e:*) {
					projectile.y = e.position * slope + inter;
					caller.currentRoom.applyTileLightingFromSource(caller.currentRoom, caller.currentRoom.x + projectile.x, caller.currentRoom.y + projectile.y)
				},
				function (e:*) {
					caller.currentRoom.removeChild(projectile);
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
