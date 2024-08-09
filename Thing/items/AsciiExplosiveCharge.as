package items {
	
	import flash.display.MovieClip;
	import items.*
	import flash.geom.ColorTransform;
	import flash.events.MouseEvent;
	import GlobalState;
	import characters.*;
	import effects.AsciiParticleSystem;
	import flash.geom.Point;
	import asciiRooms.AsciiRoomBase;
	import flash.events.Event;
	
	
	public class AsciiExplosiveCharge extends ExplosiveCharge {
		
		
		public function AsciiExplosiveCharge() {
			// constructor code
			// stop();
		}

		override protected function getSelection(): MovieClip {
			return asciiSelection;
		}

		override protected function interactOnMouseDown(e:MouseEvent): void {}
		override protected function interactOnMouseUp(e:MouseEvent): void {}

		override protected function highlightForInteraction(): void {
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().visible = false;
		}


		override protected function interactOnMouseOver(e:MouseEvent): void
		{
				highlightForInteraction();
		}
		

		public var cameraLayer;

		override protected function interactOnMouseClick(e:MouseEvent): void
		{			
			//explode
			if(isCharged && GlobalState.activePlayer != null)
			{
				GlobalState.activePlayer.currentRoom.moveCharacterToRoom(GlobalState.activePlayer as Player);
				GlobalState.activePlayer.finalizeAction();
				
				GlobalState.plantedCharges.forEach(function(charge:*) {charge.explode()})
				GlobalState.plantedCharges = [];
				return;
			}

			if(!owner.AlreadyActed)
			{
				trace(owner, "has planted explosive charge in", owner.currentRoom);				
				this.visible = false;
				//todo: detach from owner rather than creating new instance
				var plantedCharge = new AsciiExplosiveCharge();
				plantedCharge.visible = true;
				plantedCharge.isCharged = true;
				plantedCharge.currentRoom = owner.currentRoom;
				plantedCharge.gotoAndPlay(5);
				
				plantedCharge.cameraLayer = owner.cameraLayer;
				AsciiRoomBase(owner.currentRoom).spawnInteractable(plantedCharge, owner.cameraLayer)
				
				GlobalState.plantedCharges.push(plantedCharge);
			
				owner.finalizeAction();
			}
		}

		

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
			var p = new AsciiParticleSystem(100, false, cameraLayer);
			p.x = this.x + 25+ 12.5;
			p.y = this.y + 20.125;
			cameraLayer.addChild(p);
			stop();
		}
	}
	
}
