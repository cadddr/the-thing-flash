package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import Globals;
	
	public class Room extends MovieClip {
		
		var id : int;
		var destroyed : Boolean = false;
		var type : String;
		var characters : Array = []
		
		
		public function Room(id : int = -1, type : String = "regular") 
		{
			this.id = id;
			this.type = type;
			
			
			//highlighting
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
					
		}
		
		private function onMouseOver(event : MouseEvent) 
		{
			trace(this);
			if (Globals.highlightedRoom != null)
				Globals.highlightedRoom.gotoAndStop(1); 
			Globals.highlightedRoom = this;
			gotoAndStop(2); 
		}
	}
	
}
