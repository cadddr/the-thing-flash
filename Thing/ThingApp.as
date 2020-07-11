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
								  
		var rooms : Array = [];
		var redPlayers : Vector.<MovieClip> = new Vector.<MovieClip>();
		const maxPlayers = 7;
		
		public function ThingApp() {

			rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
			for (var room in rooms)
			{
				room1.addEventListener(MouseEvent.MOUSE_OVER, function(e:MouseEvent){trace(this); gotoAndStop(2)});
				room1.addEventListener(MouseEvent.MOUSE_OUT, function(e:MouseEvent){gotoAndStop(1)});
			}
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player(String.fromCharCode(97 + i));
				
				redPlayers.push(player);
				parent.addChild(player);
				
				PutInCorridor8(player, rooms[7]);
			}
			
			
			
			var roomNumber = Math.round(Math.random() * (rooms.length - 1));
			
			trace(roomNumber + 1);
			//PutInRoom(redPlayer, rooms[roomNumber]);
			
		}
		function onRoomOver(e:MouseEvent)
		{
			e.target.gotoAndStop(2);
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
		
		private function PutInCorridor7(whom : MovieClip, where : MovieClip)
		{
			const wideness = 39.25;
			var offset_x = 0;
			var offset_y = 0;
			var correction_x = 0;
			var correction_y = 0;
			
			//to ensure iid of the character distribution between the two parts of the corridor
			if(Math.random() >= 0.5)
			{
				//pick an x
				offset_x = Math.random() * where.width;	
				
				//x floor
				//correction_x = (offset_x - where.x) < whom.width / 2 ? whom.width / 2 : correction_x;
				
				//choose an y restricted to chosen x
				if (offset_x < wideness)
				{
					offset_y = Math.random() * where.height;
					
					// x ceil at the little adjacent corridor
					//correction_x = (wideness - offset_x) < whom.width / 2 ? whom.width / 2 : correction_x
				}
				else 
				{
					offset_y = Math.random() * wideness;		
					
					//x ceil
					//correction_x = (where.x - offset_x) < whom.width / 2 ? whom.width / 2 : correction_x;
				}
			}
			
			else
			{
				//pick an y
				offset_y = Math.random() * where.height;						
				
				//choose an x restricted to chosen y
				if (offset_y < wideness)
					offset_x = Math.random() * where.width;
				else 
					offset_x = Math.random() * wideness;	
			}
			
			whom.x = where.x + offset_x;	
			whom.y = where.y + offset_y;
		}
		
		private function PutInCorridor8(whom : MovieClip, where : MovieClip)
		{
			const wideness = 39.25;
			var offset_x = 0;
			var offset_y = 0;
			
			//to ensure iid of the character distribution between the two parts of the corridor
			if(Math.random() >= 0.5)
			{
				//pick an x
				offset_x = Math.random() * where.width;	
				
				//choose an y restricted to chosen x
				if (offset_x < wideness)
				{
					offset_y = Math.random() * where.height;
				}
				else 
				{
					offset_y = Math.random() * wideness;		
				}
			}
			
			else
			{
				//pick an y
				offset_y = Math.random() * where.height;						
				
				//choose an x restricted to chosen y
				if (offset_y < wideness)
					offset_x = Math.random() * where.width;
				else 
					offset_x = Math.random() * wideness;	
			}
			
			whom.x = where.x - offset_x;	
			whom.y = where.y - offset_y;
		}
		
		
	}
	
}
