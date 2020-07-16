package rooms {
	
	import rooms.Room;
	import characters.*;
	
	public class Room7 extends Room 
	{
		public function Room7() 
		{
			super();
		}
		
		override protected function computePositionInRoom(whom:Character):Array	
		{
			const wideness = 39.25;
			var offset_x = 0;
			var offset_y = 0;
			var correction_x = 0;
			var correction_y = 0;

			//to ensure iid of the character distribution between the two parts of the corridor
			if (Math.random() >= 0.5)
			{
				//pick an x
				offset_x = Math.random() * width;

				//x floor
				//correction_x = (offset_x - where.x) < whom.width / 2 ? whom.width / 2 : correction_x;

				//choose an y restricted to chosen x
				if (offset_x < wideness)
				{
					offset_y = Math.random() * height;

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
				offset_y = Math.random() * height;

				//choose an x restricted to chosen y
				if (offset_y < wideness)
				{
					offset_x = Math.random() * width;
				}
				else
				{
					offset_x = Math.random() * wideness;
				}

			}
			
			var destinationX = x + offset_x;
			var destinationY = y + offset_y;
			
			return [destinationX, destinationY];
		}
	}
	
}
