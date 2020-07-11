package  
{
		import flash.display.MovieClip;
	import GlobalState;	
	import flash.events.*; 
	
	public class ThingModel extends MovieClip 
	{
		private var distribution = [];

		public function ThingModel(nonInfectedRoom:int) 
		{
			for (var i:int = 0; i < GlobalState.rooms.length; i++)
			{
				distribution.push(i != nonInfectedRoom 
								  ? 1 / (GlobalState.rooms.length - 1)
								  : 0);
			}
			
		}
		
		public function commitObservation(room:int)
		{
			distribution[room] = 1;
			normalize();
		}
		
		public function RoomLikelyhood(room:int)
		{
			return distribution[room];
		}
		
		
		private function normalize()
		{
			var sum:Number = 0;
			distribution.forEach(function(e:*) {sum += e});
			distribution = distribution.map(function(e:*) {return e / sum});
		}
		
		override public function toString():String
		{
			var string:String = new String();
			for(var i:int = 0; i < distribution.length; i++)
			{
				string += "Room" + (i + 1) + ":\t" + distribution[i] + "\n";
			}
			
			return string;
		}

	}
	
}
