package items {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import characters.Player;
	
	public class Item extends MovieClip{
		
		public var owner:Player;
		
		public function Item() 
		{
			this.visible = false;
			addEventListener(MouseEvent.CLICK , onClick);
		}
		
		protected function onClick(e:MouseEvent)
		{
		
		}

	}
	
}
