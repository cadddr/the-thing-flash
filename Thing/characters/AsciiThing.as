package characters {
	
	import flash.display.MovieClip;
	import characters.*;
	import Utils;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	import GlobalState;
	import flash.events.*
	import flash.geom.ColorTransform;
	import flash.display.Shape;
	import asciiRooms.AsciiRoomBase;
	
	public class AsciiThing extends Thing {
		
		private const DIE_FRAME = 11;
		private const ATTACK_FRAME = 20;
		
		public function AsciiThing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability) {
			super(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability);
			unhighlightForInteraction();
		}

		protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
			
			if (GlobalState.DEBUG) {
				GlobalState.activeOverlay = new Shape()
				GlobalState.activeOverlay.graphics.lineStyle(1, 0xFF0000, 1);
				GlobalState.activeOverlay.graphics.moveTo(
					GlobalState.activePlayer.x - currentRoom.x, 
					GlobalState.activePlayer.y - currentRoom.y
				)
				GlobalState.activeOverlay.graphics.lineTo(x - currentRoom.x + GlobalState.TILE_WIDTH / 2, y - currentRoom.y + GlobalState.TILE_HEIGHT / 2)
				currentRoom.addChild(GlobalState.activeOverlay)
			}
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

		override protected function attack(victim:Player) {
			camera.pinCameraToObject(this, 0, 0);
			if (currentRoom != null) //TODO:
			{AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x - GlobalState.TILE_WIDTH / 2, y - GlobalState.TILE_HEIGHT / 2);}
		
			gotoAndPlay(ATTACK_FRAME);

			var caller = this;
			Utils.tweenValueAndFinish({"x":0}, "x", Regular.easeOut, caller.x, victim.x, .2,
				function (e:*) {
					trace('waiting to pin to victim')
				},
				function (e:*) {
					camera.pinCameraToObject(victim, 0, 0);	
					if (victim.currentRoom != null) //TODO:
					{AsciiRoomBase(victim.currentRoom).applyTileLightingFromSource(victim.currentRoom, victim.x - GlobalState.TILE_WIDTH / 2, victim.y - GlobalState.TILE_HEIGHT / 2);}
					caller.attackVictim(victim);
				});
		}
		function attackVictim(victim: Player) {
			super.attack(victim);
		}

		override protected function dieAnimation() {
			getSelection().visible = false;
			// transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
			var explosion = new SparkExplosion();
			explosion.x = x - currentRoom.x;
			explosion.y = y - currentRoom.y;
			currentRoom.addChild(explosion);
			explosion.gotoAndPlay(1);

			Utils.tweenValueAndFinish({"x": 0}, "x", None.easeNone, 0, 10., 0.5, function(e:TweenEvent) {
				AsciiRoomBase(currentRoom).setFloorBackgroundColor(e.position);
			}, function(e:TweenEvent) {
				AsciiRoomBase(currentRoom).setFloorBackgroundColor(1.);
			});

			gotoAndPlay(DIE_FRAME);
		}
	}	
}
