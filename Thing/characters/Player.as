package characters {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import GlobalState;
	import characters.Character;

	public class Player extends Character {
		protected var infectedRefusalProbability;
		protected var spawnThing: Function;

		private var alreadyActed: Boolean = false;
		public function get AlreadyActed(): Boolean {
			return alreadyActed;
		}

		public function set AlreadyActed(value) {
			alreadyActed = value;
			
			value ? markAlreadyActed() : markReadyToAct();
		}

		protected function markAlreadyActed(): void {throw null;}
		protected function markReadyToAct(): void {throw null;}

 		protected var isInfected: Boolean = false;
		public function get IsInfected() {
			return isInfected;
		}

		public function get Roommates(): Array {
			return currentRoom.getRoommates(this);
		}

		public function get SeenThings(): int {
			return currentRoom.VisibleThings.length;
		}

		//public var revelationCallback:Function = null;

		public function Player(infectedRefusalProbability, spawnThing) {
			this.infectedRefusalProbability = infectedRefusalProbability;
			this.spawnThing = spawnThing;

			transform.colorTransform = new ColorTransform(0, 0, 0, 1, Math.random() * 255, Math.random() * 255, Math.random() * 255); // Random color?
		}

		public function getSyringe(): MovieClip {throw null;}
		public function getCharge(): MovieClip {throw null;}

		public function equipSyringe() {
			trace(this, "has equipped test syringe")
			getSyringe().equip(this)
		}

		public function equipExplosiveCharge() {
			trace(this, "has equipped explosive charge")
			getCharge().equip(this);
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

		// start drag
		// mouse up handled by stage
		override protected function interactOnMouseDown(e: MouseEvent): void {
			if (!AlreadyActed) {
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
				var revealedThing = spawnThing();

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
			AlreadyActed = true; //for not acting anymore
			dieAnimation();
		}

		protected function initializeAction() {
			currentRoom.highlightReachableRooms();
			stage.setChildIndex(this, stage.numChildren - 1);
			GlobalState.draggableCharacter = this;
			startDrag();

			mouseEnabled = false;
		}

		public function finalizeAction() {

			stopDrag();
			mouseEnabled = true;
			GlobalState.draggableCharacter = null;
			AlreadyActed = true;
		}

		public override function toString(): String {
			return "Player " + this.transform.colorTransform.color.toString(16);
		}
	}
}