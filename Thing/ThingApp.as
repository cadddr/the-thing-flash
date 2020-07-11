package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

		
	public class ThingApp extends MovieClip {
		
		var passabilityMap : Array = [[0, 0, 0, 0, 0, 0, 1, 1],
								  [0, 0, 0, 0, 0, 0, 1, 0],
								  [0, 0, 0, 0, 0, 0, 1, 0],
								  [0, 0, 0, 0, 0, 0, 1, 0],
								  [0, 0, 0, 0, 0, 0, 0, 1],
								  [0, 0, 0, 0, 0, 0, 0, 1],
								  [1, 1, 1, 1, 0, 0, 0, 1],
								  [0, 0, 0, 0, 1, 1, 1, 0]];
								  
		var rooms : Array;
		
		
		public function ThingApp() {

			var redPlayer = new Player();
			
			parent.addChild(redPlayer);
			
			rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			var roomNumber = Math.round(Math.random() * (rooms.length - 1));
			
			trace(roomNumber + 1);
			PutInRoom(redPlayer, rooms[roomNumber]);
		}
		
		// puts a character at a random location within a specified room
		private function PutInRoom(whom : MovieClip, where : MovieClip)
		{					
			trace(where.x, where.y);
			
			var offset_x = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * where.width / 2;
			var correction_x = offset_x < 0 ? whom.width / 2 : - whom.width / 2
								
			whom.x = where.x + offset_x + correction_x;			
			
			var offset_y = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * where.height / 2;
			var correction_y = offset_y < 0 ? whom.height / 2 : - whom.height / 2
			
			whom.y = where.y + offset_y + correction_y;	
			
			trace(offset_x + correction_x, offset_y + correction_y);
			trace(whom.x, whom.y);
		}
		
		
	}
	
}
