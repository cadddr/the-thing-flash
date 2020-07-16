package items {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import characters.Player;
	import items.Item;
	
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
				owner.currentRoom.revealInfectedPlayers();
				gotoAndPlay(1);
				owner.finalizeAction();
			}
		}
		
		private function dispose()
		{
			this.gotoAndStop(1);
			this.visible = false;
		}
	}
	
}
