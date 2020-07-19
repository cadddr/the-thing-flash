package items {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import characters.Player;
	import characters.Interactable;
	
	public class Item extends Interactable {
		
		public var owner:Player;
		
		public function Item() 
		{
			this.visible = false;
		}

	}
	
}
