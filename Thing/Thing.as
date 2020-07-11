package  {
	
	import flash.display.MovieClip;
	
	
	public class Thing extends MovieClip {
		
		public var currentRoom:Room;
		public function Thing() {
			currentRoom = null;
		}
		
		public function goVisible()
		{
			alpha = 1;
		}
		
		public function goInvisible()
		{
			alpha = 0.2;
		}
		
		public function act()
		{
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
