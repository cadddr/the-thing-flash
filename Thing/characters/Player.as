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

 		private var isInfected: Boolean = false;
		public function get IsInfected() {
			return isInfected;
		}

		public function set IsInfected(value) {
			isInfected = value;
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

		protected function attemptAction() {
			if (!AlreadyActed) {
				if (this.IsInfected) {
					trace("Is", this, "going to refuse to execute the order?");
					if (Utils.getRandom(6, 1) <= infectedRefusalProbability) {
						this.revealItself();
						return;
					}
				}

				initializeAction();
			}
		}

		protected function initializeAction() {throw null;}
		public function finalizeAction() {throw null;}

		public function getInfected(infection: Function) {
			trace(this, "got infected");
			policy = infection;

			currentRoom.refreshThingsVisibility();
			if (infection != null) // TODO: how can it be set with null? isn't things policy always same
				IsInfected = true;
		}

		public function revealItself() {
			if (IsInfected) {
				var revealedThing = spawnThing();

				cameraLayer.addChild(revealedThing);

				var tmpX = this.x;
				var tmpY = this.y;
				var tmpRoom = this.currentRoom;

				this.die();
				cameraLayer.removeChild(this);

				tmpRoom.register(revealedThing); // TODO: why this needs to happen afterwards?
				revealedThing.x = tmpX;
				revealedThing.y = tmpY;

				revealedThing.IsVisible = true;

				//assuming the thing will act after players act
			}

			//revelationCallback(this, IsInfected);
		}

		public override function toString(): String {
			return "Player " + this.transform.colorTransform.color.toString(16);
		}
	}
}