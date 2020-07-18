package characters {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import GlobalState;
	import characters.Character;

	public class Player extends Character {
		protected var infectedRefusalProbability;

		protected var alreadyActed: Boolean = false;
		protected var isInfected: Boolean = false;

		//public var revelationCallback:Function = null;

		public function Player(infectedRefusalProbability) {
			this.infectedRefusalProbability = infectedRefusalProbability;

			transform.colorTransform = new ColorTransform(0, 0, 0, 1, Math.random() * 255, Math.random() * 255, Math.random() * 255);
		}

		public function get IsInfected() {
			return isInfected;
		}

		public function set IsInactive(value) {
			if (value)
				gotoAndStop(23);
			else
				gotoAndStop(1);

			alreadyActed = value;
		}

		public function get IsInactive(): Boolean {
			return alreadyActed;
		}

		public function get Roommates(): Array {
			return currentRoom.getRoommates(this);
		}

		public function get SeenThings(): int {
			return currentRoom.VisibleThings.length;
		}

		

		public function equipSyringe() {
			trace(this, "has equipped syringe")
			this.mysyringe.visible = true;
			this.mysyringe.owner = this;
		}

		public function equipExplosiveCharge() {
			trace(this, "has equipped explosive charge")
			this.mycharge.visible = true;
			this.mycharge.owner = this;
		}

		override protected function highlightForInteraction(): void {
			gotoAndPlay(2);
		}

		override protected function unhighlightForInteraction(): void {
			gotoAndPlay(1);
		}

		override protected function interactOnMouseOver(e: MouseEvent): void {
			if (!alreadyActed) {
				highlightForInteraction();
			}
				
		}

		override protected function interactOnMouseOut(e: MouseEvent): void {
			if (!alreadyActed) {
				unhighlightForInteraction();
			}				
		}

		



		// start drag
		// mouse up handled by stage
		override protected function interactOnMouseDown(e: MouseEvent): void {
			if (!alreadyActed) {
				if (this.isInfected) {
					trace("Is", this, "going to refuse to execute the order?");
					if (Utils.getRandom(6, 1) <= infectedRefusalProbability) {
						this.revealItself();
						return;
					}
				}

				initializeAction();
			}
		}

		public function getInfected(infection: Function) {
			trace(this, "got infected");

			this.IsVisible = false;

			policy = infection;

			if (infection != null)
				isInfected = true;
		}

		public function revealItself() {
			if (isInfected) {
				var revealedThing = new Thing();

				stage.addChild(revealedThing);

				var tmpX = this.x;
				var tmpY = this.y;

				var tmpRoom = this.currentRoom;

				this.die();
				stage.removeChild(this);

				tmpRoom.register(revealedThing);

				revealedThing.x = tmpX;
				revealedThing.y = tmpY;

				revealedThing.goVisible();

				//assuming the thing will act after players act
			}

			//revelationCallback(this, isInfected);
		}


		override public function die() {
			trace(this, "died");

			super.die()
			gotoAndStop(24);
			//for not acting anymore
			alreadyActed = true;

		}

		protected function initializeAction() {
			currentRoom.highlightReachableRooms(true);
			stage.setChildIndex(this, stage.numChildren - 1);
			GlobalState.draggableCharacter = this;
			startDrag();

			mouseEnabled = false;
		}

		public function finalizeAction() {

			stopDrag();
			mouseEnabled = true;
			GlobalState.draggableCharacter = null;
			IsInactive = true;


		}

		public override function toString(): String {
			return "Player " + this.transform.colorTransform.color.toString(16);
		}

	}

}