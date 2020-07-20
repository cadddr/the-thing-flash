package items {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import characters.Player;
	import items.Item;
	
	public class Syringe extends Item {
		
		public function Syringe() 
		{
			super();
			this.addFrameScript(29, dieAnimation);
		}
		
		override protected function interactOnMouseClick(e:MouseEvent): void
		{			
			if(!owner.IsInactive)
			{
				trace(owner, "has used syringe");
				owner.currentRoom.revealInfectedPlayers();
				dieAnimation();
				owner.finalizeAction();
			}
		}
		
		private function dieAnimation()
		{
			this.gotoAndStop(1);
			this.visible = false;
		}
	}
	
}
