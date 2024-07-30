package characters {
	
	import characters.Player
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import items.AsciiSyringe;
	import asciiRooms.AsciiRoomBase;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	
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
			previousRoom.unhighlightReachableRooms();
			currentRoom.unhighlightReachableRooms();
			GlobalState.draggableCharacter = null;
			AlreadyActed = true;

			unhighlightForInteraction();
		}

		// TODO:
		var tweenX: Tween;
		var tweenY: Tween;

		public function animateMoveTo(x:Number, y:Number) {
			if (camera != null) {
				camera.pinCameraToObject(this);
			}

			gotoAndPlay(1);

			tweenX = new Tween(this, "x", Strong.easeInOut, this.x, x, 1, true);
			tweenY = new Tween(this, "y", Strong.easeInOut, this.y, y, 1, true);
			var caller:MovieClip = this;

			tweenX.addEventListener(TweenEvent.MOTION_CHANGE, function(e:TweenEvent) {
				if (currentRoom)
				{
					AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, e.position, caller.y);
				}
				if (previousRoom)
				{
					AsciiRoomBase(previousRoom).applyTileLightingFromSource(previousRoom, e.position, caller.y);
				}
			})

			tweenY.addEventListener(TweenEvent.MOTION_CHANGE, function(e:TweenEvent) {
				if (currentRoom)
				{
					AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, caller.x, e.position);
				}
				if (previousRoom)
				{
					AsciiRoomBase(previousRoom).applyTileLightingFromSource(previousRoom, caller.x, e.position);
				}
			})

			var helper: Function = function (first: Tween, second: Tween): void {
				second.stop();
				first.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent): void {second.start();});

				second.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {gotoAndStop(24);});
			}

			if (Math.abs(x - this.x) > Math.abs(y - this.y)) {
				helper(tweenX, tweenY)
			}
			else {
				helper(tweenY, tweenX);
			}
		}	
		///

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
		}
	}
}
