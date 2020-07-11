package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import Globals;
	
	public class Thing extends MovieClip {
		
		public var currentRoom:Room;
		private var isDead:Boolean;
		
		public function Thing() 
		{
			
			currentRoom = null;
			isDead = false;
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);			
			
			//for getting attacked by the dragged player
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		private function onMouseOver(e:MouseEvent)
		{
			if(!isDead)
				if(Globals.draggableCharacter && currentRoom == Globals.draggableCharacter.currentRoom)
					gotoAndPlay(2);
		}
		
		private function onMouseOut(e:MouseEvent)
		{
			
				gotoAndStop(1);
		}
		
		//gets killer by a dragger
		private function onMouseUp(e:MouseEvent)
		{
			if(!isDead)
				if(Globals.draggableCharacter && currentRoom == Globals.draggableCharacter.currentRoom)
			 		
					//dice roll should be 2
					if(Math.round(Math.random() * 5) < 6)
					{
						transform.colorTransform = new ColorTransform(0, 0, 0, 1, 0, 0, 0);
						isDead = true;
						gotoAndStop(1);
					}
					
					//needs refactoring
					mouseEnabled = false;
					Globals.draggableCharacter.stopDrag();
					Globals.draggableCharacter.IsInactive = true;
					currentRoom.putIn(Globals.draggableCharacter as Player);
					
					Globals.draggableCharacter = null;
		}
		
		public function goVisible()
		{
			alpha = 1;
		}
		
		public function goInvisible()
		{
			if(!isDead)
				alpha = 0.2;
		}
		
		public function act()
		{
			if(!isDead)
				goToRandomReachableRoom();
			
		}
		
		
		private function get ReachableRooms()
		{
			var originRoomIndex:int = 0;
			
			if (currentRoom is Room1)
				originRoomIndex = 0			
			
			else if (currentRoom is GenRoom)
				originRoomIndex = 1
				
			else if (currentRoom is Room3)
				originRoomIndex = 2
				
			else if (currentRoom is AmmoRoom)
				originRoomIndex = 3
			
			else if (currentRoom is TestRoom)
				originRoomIndex = 4
				
			else if (currentRoom is Room6)
				originRoomIndex = 5
				
			else if (currentRoom is Room7)
				originRoomIndex = 6
				
			else if (currentRoom is Room8)
				originRoomIndex = 7;
			
			
			var passabilityList = Globals.adjacencyMap[originRoomIndex];
			var reachableRooms:Array = []
				for(var i:int = 0; i < passabilityList.length; i++)
				{
					if (passabilityList[i] == 1)
					{
						reachableRooms.push(Globals.rooms[i])
					}
				}
				
			return reachableRooms;
		}
		
		private function goToRandomReachableRoom()
		{
			ReachableRooms[Math.round(Math.random() * (ReachableRooms.length - 1))].putIn(this);
		}
	}
	
}
