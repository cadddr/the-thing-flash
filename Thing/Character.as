package  {
	import flash.display.MovieClip;
	import GlobalState;
	
	public class Character extends MovieClip{
		
		public var policy:Function = null;
		public var currentRoom:Room = null;
		public var previousRoom:Room = null;
		
		public var isDead:Boolean = false;
		
		public function set IsVisible(value:Boolean)
		{
			if(value)
				alpha = 1;
			else if(GlobalState.DEBUG)
				alpha = 0.3;
		}
		
		
		protected function get ReachableRooms():Array
		{
			return currentRoom.accessibleRooms;
		}
		
		
		public function Character()
		{
			scaleX = 1.25;
			scaleY = 1.25;
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
				currentRoom.highlightReachableRooms(false);
				previousRoom = currentRoom;
				
				currentRoom.getOut(this);				
			}
		}
	}
	
}
