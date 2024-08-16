package characters {
	
	import flash.display.MovieClip;
	import characters.*;
	import Utils;
	import GlobalState;
	import flash.events.*
	import flash.geom.ColorTransform;
	import flash.display.Shape;
	import asciiRooms.AsciiRoomBase;
	
	public class AsciiThing extends Thing {
		
		private const DIE_FRAME = 11;
		public function AsciiThing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability) {
			super(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability);
			unhighlightForInteraction();
		}

		protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
			
			GlobalState.activeOverlay = new Shape()
			GlobalState.activeOverlay.graphics.lineStyle(3, 0xFF0000, 1);
			GlobalState.activeOverlay.graphics.moveTo(
				GlobalState.activePlayer.x - currentRoom.x + GlobalState.TILE_WIDTH / 2, 
				GlobalState.activePlayer.y - currentRoom.y + GlobalState.TILE_HEIGHT / 2
			)
			GlobalState.activeOverlay.graphics.lineTo(x - currentRoom.x + GlobalState.TILE_WIDTH / 2, y - currentRoom.y + GlobalState.TILE_HEIGHT / 2)
			currentRoom.addChild(GlobalState.activeOverlay)
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().visible = false;	
			if (GlobalState.activeOverlay != null && GlobalState.activeOverlay.parent == currentRoom) { // TODO: what if there is another overlay
				currentRoom.removeChild(GlobalState.activeOverlay)
				GlobalState.activeOverlay = null;
			}
		}

		// TODO: extract condition to logic
		override protected function interactOnMouseOver(e:MouseEvent): void {
			if(GlobalState.activePlayer && currentRoom == GlobalState.activePlayer.currentRoom) {
				highlightForInteraction();
			}
		}
		
		override protected function interactOnMouseOut(e:MouseEvent): void {
				unhighlightForInteraction();
		}

		override protected function interactOnMouseClick(e: MouseEvent): void {
			if (GlobalState.activePlayer) {
				AsciiPlayer(GlobalState.activePlayer).weaponAnimation(x, y);
				getAttackedByPlayer();
			}	
		}

		override protected function dieAnimation() {
			getSelection().visible = false;
			// transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
			var explosion = new SparkExplosion();
			explosion.x = x - currentRoom.x;
			explosion.y = y - currentRoom.y;
			currentRoom.addChild(explosion);
			explosion.gotoAndPlay(1);

			AsciiRoomBase(currentRoom).setFloorBackgroundColor(10.)
			gotoAndStop(DIE_FRAME);
		}
	}	
}
