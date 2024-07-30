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
			removeEventListener(MouseEvent.CLICK, interactOnMouseClick);
		}
		
		override protected function interactOnMouseClick(e:MouseEvent): void
		{			
			if(!owner.AlreadyActed)
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
			removeEventListener(MouseEvent.CLICK, interactOnMouseClick);
		}

		public function equip(owner: Player): void {
			visible = true;
			addEventListener(MouseEvent.CLICK, interactOnMouseClick);
			this.owner = owner;
		}
	}
	
}
