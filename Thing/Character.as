package  {
	import flash.display.MovieClip;
	
	public class Character extends MovieClip{
		
		public var policy:Function = null;
		public var currentRoom:Room = null;
		public var previousRoom:Room = null;
		
		public var isDead:Boolean = false;
		
		public function set Visible(value:Boolean)
		{
			if(value)
				alpha = 1;
			else
				alpha = 0.3;
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
				var characterIndex = currentRoom.characters.indexOf(this)
				currentRoom.characters.splice(characterIndex, 1);
			}
		}
		
		

	}
	
}
