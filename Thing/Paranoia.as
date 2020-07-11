package  {
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import BeliefState;
	public class Paranoia extends MovieClip
	{
		private var beliefStates:Array = [];
		private var suspects:Array = [];
		
		public function Paranoia(suspects:Array) 
		{
			var initialState = new BeliefState(suspects, 1);
			beliefStates.push(initialState);
						
			this.suspects = suspects;
		}
	
		public override function toString():String
		{
			var string = "----------"
					 + "\n|Paranoia|"
					 + "\n----------"
					 + "\n";
			
			for (var i:int = 0; i < beliefStates.length; i++)
			{
				string += beliefStates[i].toString() + "\n";
			}
			return string;
		}
		
		public function updateBeliefs()
		{
			for (var i:int = 0; i < beliefStates.length; i++)
			{
				//observed_state * belief_states[] = outcomes[][]
			}
		}
		
		private function branch()
		{
			
		}
		
		private function prune()
		{
		}
		
		
		/*
		public function updateProbabilities()
		{
			var numInitialThings:Number = 1;
			var numThings:Number = numInitialSuspects - length(suspects) + numInitialThings;
			var numRooms:Number = 8;
			
			for(var suspect:* in this.suspects)
			{
				if(suspect.Roommates.length < numThings)
				{
					var numPlayers = suspect.Roommates + 1;
					var thingMargin = numThings - numPlayers;
					this.suspects[suspect] +=  Math.pow(1 / numRooms, numPlayers) + thingMargin / numRooms;
				}
			}
		}
		
		*/
		
		public static function length(myDictionary:Dictionary):int 
		{
			var n:int = 0;
			for (var key:* in myDictionary) {
				n++;
			}
			return n;
		}

	}
	
}
