package levels {
	
	import flash.display.MovieClip;
	import flash.events.*; 
	import Utils;
	
	public class LevelBase extends MovieClip {
		protected var maxPlayers = 5;	
		
		protected var playerReachabilityMap : Array = [[1, 0, 0, 0, 0, 0, 1, 1],
													   [0, 1, 0, 0, 0, 0, 1, 0],
														[0, 0, 1, 0, 0, 0, 1, 0],
														[0, 0, 0, 1, 0, 0, 1, 0],
														[0, 0, 0, 0, 1, 0, 0, 1],
														[0, 0, 0, 0, 0, 1, 0, 1],
														[1, 1, 1, 1, 0, 0, 1, 1],
														[1, 0, 0, 0, 1, 1, 1, 1]];
													
		protected var thingReachabilityMap : Array = [[1, 1, 0, 0, 0, 0, 1, 1],
														  [1, 1, 0, 0, 0, 0, 1, 1],
														  [0, 0, 1, 1, 0, 1, 1, 1],
														  [0, 0, 1, 1, 1, 0, 1, 1],
														  [0, 0, 0, 1, 1, 1, 0, 1],
														  [0, 0, 1, 0, 1, 1, 0, 1],
														  [1, 1, 1, 1, 0, 0, 1, 1],
														  [1, 1, 1, 1, 1, 1, 1, 1]];
		
				//out of 6
		protected var leftBehindProbability:Number = 2
		
		protected var humanInfectedRefusalProbability = 2;

		public function LevelBase() {
			// constructor code
		}
		
		protected function get Players()
		{
			var players = [];
			GlobalState.rooms.forEach(function(room:*) 
									  {
										  room.Players.forEach(function(player:*)
															   {
																   players.push(player);
															   });
									  });									  
			return players;
		}
		
		protected function get Things()
		{
			var things = []
			GlobalState.rooms.forEach(function(room:*)
									  {
										  room.Things.forEach(function(thing:*)
															  {
																  things.push(thing);
															  });
									  });
			return things;
		}
		
		//todo: make look nicer
		protected function reachabilityMaps2AdjacencyLists(rooms:Array)
		{
			for(var i:int = 0; i < rooms.length; i++)
			{
				for(var j:int = 0; j < playerReachabilityMap[i].length; j++)
				{
					if(playerReachabilityMap[i][j] == 1)
					{
						rooms[i].accessibleRooms.push(rooms[j]);
					}
					
					if(thingReachabilityMap[i][j] == 1)
					{
						rooms[i].adjacentRooms.push(rooms[j]);
					}
				}
			}
		}
		
		protected function initializePlayers()
		{
			trace("Where do humans start?")
			var initialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;
		
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player(humanInfectedRefusalProbability);
				//player.revelationCallback = function(myplayer:Player, isInfected:Boolean){paranoia.considerEvidence(myplayer, isInfected)};
								
				GlobalState.rooms[initialRoom].putIn(player);
				stage.addChild(player);					
			}
		}
		
		protected function initializeThing()
		{
			var thing = new Thing();
			
			//todo: needs refactoring
			trace("Where does", thing, "start?");
			var thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;
			
			if(!GlobalState.rooms[thingsInitialRoom].IsTakenOver)
			{
				trace(thing, "needs another room to start?");
				thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length - 1, 0, thingsInitialRoom);
			}
			
			GlobalState.rooms[thingsInitialRoom].putIn(thing);
			stage.addChild(thing);
		}
		
		protected function identifySquads()
		{
			var squads:Array = [];
			var checkedSquadMembers:Array = [];
			
			for (var i:int = 0; i < Players.length; i++)
			{				
				//identifying squads of players moving together
				var checkSameSquad:Function = function(item:*)
				{
					 return item.previousRoom == Players[i].previousRoom
						 && item.currentRoom == Players[i].currentRoom
						 && item.currentRoom != Players[i].previousRoom
						 && item.previousRoom != Players[i].currentRoom
						 && item.IsInactive;
				}
				
				if (!checkedSquadMembers.some(checkSameSquad)
					&& Players[i].IsInactive)
				{
					var squad:Array = Players.filter(checkSameSquad);
					
					squads.push(squad);
					//so we wouldn't consider members of the same squad twice
					checkedSquadMembers.push(Players[i]);
				}
			}				
			return squads.filter(function(squad:*) {return squad.length > 1});
		}
		
		//return random players to their previous rooms
		protected function returnRandomSquadMember(squad:*)
		{
			trace("Squad: [", squad, "]");
			trace("Will someone get left behind?");
			if(Utils.getRandom(6, 1) <= leftBehindProbability)
			{
				trace("Who's the lucky man?");
				var luckyMan:Player = squad[Utils.getRandom(squad.length - 1)];
					luckyMan.previousRoom.putIn(luckyMan);
			}
		}
		
		protected function onKeyPress(e:KeyboardEvent)
		{
			//space
			if (e.keyCode == 32)
				endTurn();
			else if (String.fromCharCode(e.charCode) == "d")
				GlobalState.DEBUG = !GlobalState.DEBUG;
				//needs improvemen
		}
		protected function endTurn()
		{						
			
		}

	}
	
}
