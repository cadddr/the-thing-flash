package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import GlobalState;
	
	public class Room extends MovieClip {
		
		var characters : Array = []	
		
		public function Room() 
		{
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);			
			
			//for putting draggable players into rooms
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function get IsReachable():Boolean
		{
			return GlobalState.reachableRooms.indexOf(this) > -1;
		}
		
		private function onMouseOver(e:MouseEvent)
		{
			if(IsReachable || GlobalState.draggableCharacter == null)
				highlightSelected();
			else
				highlightRestricted();
		}
		
		private function onMouseOut(e:MouseEvent)
		{
			if(GlobalState.reachableRooms.indexOf(this) > -1)
				highlightReachable();
			else
				unhighlight();
		}
		
		//undrags the player and puts it into the room
		private function onMouseUp(event : MouseEvent)
		{
			if(IsReachable)
			{			
				var draggableCharacter = GlobalState.draggableCharacter as Player;
				
				if(draggableCharacter != null)
				{				
					putIn(draggableCharacter);
					draggableCharacter.finalizeAction();
					
				}	
				
				resetReachableRoomsColoring();
			}
		}
		
		public function unhighlight()
		{
			gotoAndStop(1);
		}
		
		public function highlightSelected()
		{
			gotoAndStop(2);
		}
		
		public function highlightReachable()
		{
			gotoAndStop(3);
		}
		
		public function highlightRestricted()
		{
			gotoAndStop(4);
		}
		
		public function resetReachableRoomsColoring()
		{
			for (var i:int = 0; i < GlobalState.reachableRooms.length; i++)
			{				
				GlobalState.reachableRooms[i].gotoAndStop(1);
			}
			
			GlobalState.reachableRooms = [];
		}
		
		public function get IsTakenOver()
		{
			var things = characters.filter(function(item:*) {return item is Thing});
			var players = characters.filter(function(item:*){return item is Player && (!item.IsInfected)});
			var infectedPlayers = characters.filter(function(item:*){return item is Player && item.IsInfected});			
			
			return things.length + infectedPlayers.length >= players.length;			
		}
		
		public function putIn(character:MovieClip)
		{			
			//leave previous room
			if(character.currentRoom)
				character.currentRoom.characters.splice(character.currentRoom.characters.indexOf(character), 1);
				
			characters.push(character);
			character.currentRoom = this;
			
			resetReachableRoomsColoring();
			
			//refresh things' visibility
			var things = characters.filter(function(item:*) {return item is Thing})
			
			if(IsTakenOver)
				things.forEach(function(item:*){item.goInvisible()});
			else				
				things.forEach(function(item:*){item.goVisible()});
			
			
			//position in rooms
			if (this is Room7)
				positionInCorridor7(character, this); 
			else if (this is Room8)
				positionInCorridor8(character, this); 
			else
				positionInRoom(character, this);
			
		}
		
		// puts a character at a random location within a specified room
		private function positionInRoom(whom : MovieClip, where : MovieClip)
		{							
			var offset_x = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * where.width / 2;
			var correction_x = offset_x < 0 ? whom.width / 2 : - whom.width / 2
								
			whom.x = where.x + offset_x + correction_x;			
			
			var offset_y = Math.pow(-1, Math.round(Math.random() + 1)) * Math.random() * where.height / 2;
			var correction_y = offset_y < 0 ? whom.height / 2 : - whom.height / 2
			
			whom.y = where.y + offset_y + correction_y;	
		}
		
		private function positionInCorridor7(whom : MovieClip, where : MovieClip)
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
		
		private function positionInCorridor8(whom : MovieClip, where : MovieClip)
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
