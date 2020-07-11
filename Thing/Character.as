package  {
	import flash.display.MovieClip;
	
	public class Character extends MovieClip{

		public var currentRoom:Room = null;
		public var previousRoom:Room = null;
		public var isDead:Boolean = false;
		
		public function Character()
		{
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
