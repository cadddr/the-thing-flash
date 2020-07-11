package  {
	
	import flash.display.MovieClip;
	
	
	public class Room extends MovieClip {
		
		id:String;
		destroyed:Boolean = false;
		type:String;
		characters:Array = []
		
		
		public function Room(id:String, type:String) {
			this.id = id;
			this.type = type;
			
			trace(id);
		}
	}
	
}
