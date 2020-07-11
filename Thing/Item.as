package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	public class Item extends MovieClip{
		
		public var owner:Player;
		
		public function Item() 
		{
			// todo: should be invisible
			this.visible = false;
			addEventListener(MouseEvent.CLICK , onClick);
		}
		
		protected function onClick(e:MouseEvent)
		{
		
		}

	}
	
}
