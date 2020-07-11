package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Player;
	
	public class Syringe extends MovieClip {
		
		public var owner:Player;
		public function Syringe() 
		{
			this.visible = false;
			addEventListener(MouseEvent.CLICK , onClick);
		}
		
		private function onClick(e:MouseEvent)
		{
			//todo: animation with delay
			if(!owner.IsInactive)
			{
				owner.currentRoom.characters.forEach(function(item:*) {item.revealItself()});
				owner.finalizeAction();
			}
			//todo: disposable syringe
		}
	}
	
}
