package  {
	import flash.display.MovieClip;
	import GlobalState;
	
	public class Character extends MovieClip{
		
		public var policy:Function = null;
		public var currentRoom:Room = null;
		public var previousRoom:Room = null;
		
		protected var reachabilityMap:Array = null;
		
		public var isDead:Boolean = false;
		
		public function set Visible(value:Boolean)
		{
			if(value)
				alpha = 1;
			else
				alpha = 0.3;
		}
		
		public function get ReachableRooms()
		{
			var originRoomIndex:int = GlobalState.rooms.indexOf(currentRoom);			
			var passabilityList = reachabilityMap[originRoomIndex];				
			
			return GlobalState.rooms.filter(function (room:*) 
											{
												return Boolean(passabilityList[GlobalState.rooms.indexOf(room)])
											});	
		}
		
		public function Character()
		{
		}
		
		public function act()
		{
			if (!isDead)
			{
				if(policy != null)
					{
						policy();
					}
			}
		}
		
		public function die()
		{
			leaveRoom();
		}
		
		public function leaveRoom()
		{
			if (currentRoom)
			{
				ReachableRooms.forEach(function(item:*){item.unhighlight()});
				previousRoom = currentRoom;
				var characterIndex = currentRoom.characters.indexOf(this)
				currentRoom.characters.splice(characterIndex, 1);
			}
		}
		
		

	}
	
}
