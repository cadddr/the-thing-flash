package  {
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	
	public class Paranoia extends MovieClip
	{

		private var suspects:Dictionary = new Dictionary();
		private var numInitialSuspects:int;
		public function Paranoia(players:Array) 
		{
			numInitialSuspects = players.length;
			//suspects.forEach(function(suspect:*){this.suspects[suspect] = 0});			
			for (var i:int = 0; i < numInitialSuspects; i++)
			{
				this.suspects[players[i]] = 0;
			}
			
			
		}
	
		public override function toString():String
		{
			var string = "--------------------------"
					 + "\n|Infection probabilities:|"
					 + "\n--------------------------"
					 + "\n";
			
			for (var suspect:* in this.suspects)
			{
				string += suspect + "\t" + this.suspects[suspect] + "\n";
			}
			
			return string;
		}
		
		
		/*
		What can happen:
			can get infected by thing
				precond: outnumbered by thing in a room:
					ex: 1 on 1: prob + prob(thing_being_there)
			can get infected by suspect
			
			can manifest
			can syringe
		*/
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
