package items {
	
	import flash.display.MovieClip;
	import items.Item;
	import characters.*;
	import flash.events.MouseEvent;
	import fl.motion.MotionEvent;
	import rooms.RoomBase;
	
	public class ExplosiveCharge extends Item {
		
		var currentRoom:RoomBase;
		var isCharged:Boolean = false;

		public function ExplosiveCharge() {		
			unhighlightForInteraction();
		}

		protected function getSelection(): MovieClip {
			return mycharge.myselection;
		}

		override protected function highlightForInteraction(): void {
			getSelection().gotoAndPlay(1);
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().gotoAndStop(1);
			getSelection().visible = false;
		}

		protected function dieAnimation() {
			gotoAndPlay(2);
		}

		public function equip(owner: Player) {
			this.visible = true;
			this.mouseEnabled = true;
			this.owner = owner;
		}
		
		override protected function interactOnMouseOver(e:MouseEvent): void
		{
			trace ("charge on mouse over");
			if(GlobalState.draggableCharacter 
				&& currentRoom)
			{	
				trace ("passes");
				highlightForInteraction();
			}
		}
		
		override protected function interactOnMouseOut(e:MouseEvent): void
		{
			unhighlightForInteraction();
		}
		
		override protected function interactOnMouseClick(e:MouseEvent): void
		{			
			if(!owner.AlreadyActed)
			{
				trace(owner, "has planted explosive charge in", owner.currentRoom);				
				this.visible = false;
				
				var plantedCharge = new ExplosiveCharge();
				plantedCharge.x = owner.x;
				plantedCharge.y = owner.y;
				plantedCharge.visible = true;
				plantedCharge.isCharged = true;
				plantedCharge.currentRoom = owner.currentRoom;
				
				stage.addChild(plantedCharge);
				GlobalState.plantedCharges.push(plantedCharge);
			
				owner.finalizeAction();
			}
		}
		
		override protected function interactOnMouseUp(e:MouseEvent): void
		{
			//explode
			if(isCharged && GlobalState.draggableCharacter != null)
			{
				GlobalState.draggableCharacter.currentRoom.register(GlobalState.draggableCharacter as Player);
				GlobalState.draggableCharacter.finalizeAction();
				
				GlobalState.plantedCharges.forEach(function(charge:*) {charge.explode()})
				GlobalState.plantedCharges = [];
			}
				
		}
		
		protected function explode()
		{			
			trace("Charge exploded in", currentRoom);
			
			currentRoom.killGuests();
			dieAnimation();
		}
	}
	
}
