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
		
		public function commitObservation(room:int, impression:Boolean)
		{
			if(impression)
			{
				distribution[room] = 1;
			}
			else
			{
				// recursively make the thing propagate further through these rooms convoluted with probabilities
				distribution = GlobalState.thingReachabilityMap[room].map(function(r:*) {if(r==1) return 1 else return 0});
			}
			
			normalize();
		}
		
		public function update()
		{
			var futureDistribution = distribution;
			for(var i:int = 0; i < futureDistribution.length; i++)
			{
				var branchingFactor = GlobalState.thingReachabilityMap[i].length;
				for(var j:int = 0; j < futureDistribution.length; j++)
				{
					futureDistribution[j] += GlobalState.thingReachabilityMap[i][j] / branchingFactor;
				}
			}
			
			distribution = futureDistribution;
			
			normalize();
		}
		
		public function roomLikelyhood(room:int)
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
