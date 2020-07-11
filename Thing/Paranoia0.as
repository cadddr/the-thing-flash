package  
{
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	import flashx.textLayout.elements.ParagraphElement;
	import ThingModel;
	
	public class Paranoia0 extends MovieClip
	{
		private var suspects:Dictionary = new Dictionary();
		private var numInitialSuspects:int;
		private var thingModels:Array = [];
		private var pastDetection:Boolean = false;
		public function Paranoia0(players:Array) 
		{
			numInitialSuspects = players.length;
			
			for (var i:int = 0; i < numInitialSuspects; i++)
			{
				this.suspects[players[i]] = 0;
			}
			
			thingModels.push(new ThingModel(GlobalState.rooms.indexOf(players[0].currentRoom)));
			
		}
	
		public override function toString():String
		{
			traceThingModels();
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
		
		private function traceThingModels()
		{
			for(var i:int = 0; i < thingModels.length; i++)
			{
				trace("---------------------------------")
				trace("|Thing",i,"location distribution: |");
				trace("---------------------------------")
				trace(thingModels[i]);
			}
		}
		
		public function considerEvidence(suspect:Player, isInfected:Boolean)
		{
			
			suspects[suspect] = int(isInfected);
			trace("Evidence", suspect,suspects[suspect]);
		}
		
		public function updateProbabilities()
		{
			
			
			var numInitialThings:Number = 1;
			var numThings:Number = numInitialSuspects - length(suspects) + numInitialThings;
			var numRooms:Number = 8;
			
			var futureSuspects:Dictionary = clone(this.suspects);
			
			for(var victim:* in this.suspects)
			{
				if(victim.currentRoom.VisibleThings.length > 0)
				{
					thingModels[0].commitObservation(GlobalState.rooms.indexOf(victim.currentRoom), true);
					pastDetection = true;
				}
				else if(pastDetection)
				{
					thingModels[0].commitObservation(GlobalState.rooms.indexOf(victim.currentRoom), false);
					pastDetection = false;
				}
				
				var numPlayers = victim.Roommates.length + 1;
				// consider closed thing's attack scenario
				if(victim.Roommates.length < numThings)
				{
					
					var thingMargin = numThings - numPlayers;
					futureSuspects[victim] +=  thingModels[0].roomLikelyhood(GlobalState.rooms.indexOf(victim.currentRoom)) + thingMargin / numRooms;
				}
				
				// if the light is off anyone can get infected
				if(!GlobalState.isLightOn)
				{
					futureSuspects[victim] += numThings / (numRooms * numPlayers)
				}
				
				// consider roommate's attack				
				var nonInnocentSuspects = nonZeroValueKeys(victim.Roommates, this.suspects);
				
				if(nonInnocentSuspects.length > victim.Roommates.length - nonInnocentSuspects.length)
				{
					for(var i:int = 0; i < victim.Roommates.length; i++)
					{
						futureSuspects[victim] += this.suspects[victim.Roommates[i]] / victim.Roommates.length;
					}
				}	
				
				if(victim.SeenThings > 0)
				{
					var thingAssimilationProbability = 0.3;
					futureSuspects[victim] += victim.SeenThings * thingAssimilationProbability / numPlayers;
				}
				
				// normalize
				if(futureSuspects[victim] > 1) 
					futureSuspects[victim] = 1;
			}
			
			this.suspects = futureSuspects;
		}
		
		public static function length(myDictionary:Dictionary):int 
		{
			var n:int = 0;
			for (var key:* in myDictionary) 
			{
				n++;
			}
			return n;
		}
		
		public static function clone(myDictionary:Dictionary):Dictionary
		{
			var clone = new Dictionary();
			for (var key:* in myDictionary)
			{
				clone[key] = myDictionary[key]
			}
			return clone;
		}
		
		public static function nonZeroValueKeys(myDictionary:Array, suspects:Dictionary):Array
		{
			var keys = [];
			
			for (var i:int = 0; i < myDictionary.length; i++)
			{
				if (suspects[myDictionary[i]] > 0)
				{
					keys.push(myDictionary[i]);
				}
			}
			
			return keys;
		}

	}
	
}
