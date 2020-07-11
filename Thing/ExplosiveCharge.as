package  {
	
	import flash.display.MovieClip;
	import Item;
	import Room;
	import flash.events.MouseEvent;
	import fl.motion.MotionEvent;
	
	public class ExplosiveCharge extends Item {
		
		var currentRoom:Room;
		var isCharged:Boolean = false;
		public function ExplosiveCharge() 
		{		
			super();
			
			mycharge.myselection.visible = false
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver(e:MouseEvent)
		{
			if(GlobalState.draggableCharacter 
				&& currentRoom)
			{	
				mycharge.myselection.gotoAndPlay(1);
				mycharge.myselection.visible = true;
			}
		}
		
		private function onMouseOut(e:MouseEvent)
		{
			mycharge.myselection.gotoAndStop(1);
			mycharge.myselection.visible = false;
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
				
				GlobalState.plantedCharges.forEach(function(charge:*) {charge.explode()})
				GlobalState.plantedCharges = [];
			}
				
		}
		
		private function explode()
		{			
			trace("Charge exploded in", currentRoom);
			
			currentRoom.killGuests();
			gotoAndPlay(2);
		}
	}
	
}
