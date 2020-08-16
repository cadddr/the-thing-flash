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
	
	
	public class AsciiExplosiveCharge extends ExplosiveCharge {
		
		
		public function AsciiExplosiveCharge() {
			// constructor code
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
		

		var cameraLayer;

		override protected function interactOnMouseClick(e:MouseEvent): void
		{			
			//explode
			if(isCharged && GlobalState.draggableCharacter != null)
			{
				GlobalState.draggableCharacter.currentRoom.register(GlobalState.draggableCharacter as Player);
				GlobalState.draggableCharacter.finalizeAction();
				
				GlobalState.plantedCharges.forEach(function(charge:*) {charge.explode()})
				GlobalState.plantedCharges = [];
				return;
			}

			if(!owner.IsInactive)
			{
				trace(owner, "has planted explosive charge in", owner.currentRoom);				
				this.visible = false;
				//todo: detach from owner rather than creating new instance
				var plantedCharge = new AsciiExplosiveCharge();
				// var global = localToGlobal(new Point(owner.currentRoom.x, owner.currentRoom.y))
				var point = AsciiRoomBase(owner.currentRoom).computePositionInRoom(0,0,0,0);
				plantedCharge.x = point.x;
				plantedCharge.y = point.y;
				plantedCharge.visible = true;
				plantedCharge.isCharged = true;
				plantedCharge.currentRoom = owner.currentRoom;
				
				owner.cameraLayer.addChild(plantedCharge);
				GlobalState.plantedCharges.push(plantedCharge);
			
				owner.finalizeAction();
			}
		}

		

		override protected function dieAnimation() {
			transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
			var p = new AsciiParticleSystem(100, false)
			p.x = this.x;
			p.y = this.y;
			stage.addChild(p);
		}
	}
	
}
