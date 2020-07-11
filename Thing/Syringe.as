package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Player;
	import Item;
	
	public class Syringe extends Item {
		
		public function Syringe() 
		{
			super();
		}
		
		override protected function onClick(e:MouseEvent)
		{			
			//todo: animation with delay
			if(!owner.IsInactive)
			{
				trace(owner, "has used syringe");
				owner.currentRoom.characters.forEach(function(item:*) {if (item is Player) item.revealItself()});
				//to reset room coloring
				owner.currentRoom.putIn(owner);
				owner.finalizeAction();
			}
			//todo: disposable syringe
		}
	}
	
}
