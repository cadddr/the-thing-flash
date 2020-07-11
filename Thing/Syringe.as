package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Player;
	
	public class Syringe extends MovieClip {
		
		private var owner:Player;
		public function Syringe(owner:Player) 
		{
			this.owner = owner;
			addEventListener(MouseEvent.CLICK , onClick);
		}
		
		private function onClick(e:MouseEvent)
		{
			//todo: animation with delay
			if(!owner.alreadyActed)
			{
				owner.currentRoom.characters.forEach(function(item:*) {item.revealItself()});
				owner.alreadyActed = true;
			}
			//todo: disposable syringe
		}
	}
	
}
