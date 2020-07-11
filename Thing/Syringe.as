package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Player;
	import Item;
	
	public class Syringe extends Item {
		
		public function Syringe() 
		{
			super();
			this.addFrameScript(29, dispose);
		}
		
		override protected function onClick(e:MouseEvent)
		{			
			if(!owner.IsInactive)
			{
				trace(owner, "has used syringe");
				gotoAndPlay(1);
				owner.currentRoom.characters.forEach(function(item:*) {if (item is Player) item.revealItself()});
				
				//to reset room coloring
				//owner.currentRoom.putIn(owner);
				owner.finalizeAction();
			}
			//todo: disposable syringe
		}
		
		private function dispose()
		{
			this.gotoAndStop(1);
			this.visible = false;
		}
	}
	
}
