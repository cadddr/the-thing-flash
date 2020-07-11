package  {
	
	import flash.display.MovieClip;
	import Item;
	import Room;
	import flash.events.MouseEvent;
	
	public class ExplosiveCharge extends Item {
		
		var currentRoom:Room;
		var isCharged:Boolean = false;
		public function ExplosiveCharge() 
		{
			super();
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		override protected function onClick(e:MouseEvent)
		{			
			if(!owner.IsInactive)
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
				
				
				//to reset room coloring
				owner.currentRoom.putIn(owner);
				owner.finalizeAction();
			}
		}
		
		private function onMouseUp(e:MouseEvent)
		{
			//explode
			if(isCharged && GlobalState.draggableCharacter != null)
			{
				GlobalState.draggableCharacter.currentRoom.putIn(GlobalState.draggableCharacter as Player);
				GlobalState.draggableCharacter.finalizeAction();
				
				trace(GlobalState.plantedCharges)
				GlobalState.plantedCharges.forEach(function(charge:*) {charge.explode()})
				GlobalState.plantedCharges = [];
			}
				
		}
		
		private function explode()
		{			
			trace("Charge exploded in", currentRoom);
			//cloning to avoid mutability problems
			var tempChars = currentRoom.characters.concat();
			tempChars.forEach(function(item:*) {item.die()});
			gotoAndPlay(2);
		}
	}
	
}
