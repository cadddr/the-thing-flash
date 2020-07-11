package  
{
	import Room;
	import Character;
	
	public class Room8 extends Room 
	{
		
		
		public function Room8() 
		{
			super();
		}
		
		override protected function positionInRoom(whom:Character, where:Room)
		{
			const wideness = 39.25;
			var offset_x = 0;
			var offset_y = 0;

			//to ensure iid of the character distribution between the two parts of the corridor
			if (Math.random() >= 0.5)
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
				{
					offset_x = Math.random() * where.width;
				}
				else
				{
					offset_x = Math.random() * wideness;
				}

			}
			whom.x = where.x - offset_x;
			whom.y = where.y - offset_y;
		}
	}
	
}
