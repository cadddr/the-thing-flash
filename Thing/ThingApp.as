package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
	import Utils;
	import Paranoia0;
	import flashx.textLayout.formats.BackgroundColor;
	
	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class ThingApp extends MovieClip 
	{			
		private const maxPlayers = 0;	
		
		public static const playerReachabilityMap : Array = [[1, 0, 0, 0, 0, 0, 1, 1],
															[0, 1, 0, 0, 0, 0, 1, 0],
															[0, 0, 1, 0, 0, 0, 1, 0],
															[0, 0, 0, 1, 0, 0, 1, 0],
															[0, 0, 0, 0, 1, 0, 0, 1],
															[0, 0, 0, 0, 0, 1, 0, 1],
															[1, 1, 1, 1, 0, 0, 1, 1],
															[1, 0, 0, 0, 1, 1, 1, 1]];
													
		public static const thingReachabilityMap : Array = [[1, 1, 0, 0, 0, 0, 1, 1],
														  [1, 1, 0, 0, 0, 0, 1, 1],
														  [0, 0, 1, 1, 0, 1, 1, 1],
														  [0, 0, 1, 1, 1, 0, 1, 1],
														  [0, 0, 0, 1, 1, 1, 0, 1],
														  [0, 0, 1, 0, 1, 1, 0, 1],
														  [1, 1, 1, 1, 0, 0, 1, 1],
														  [1, 1, 1, 1, 1, 1, 1, 1]];
		
		//out of 6
		public static const leftBehindProbability:Number = 2
		
		public static const humanInfectedRefusalProbability = 2;
		
		
		
		var paranoia:Paranoia0;
		
		private function get Players()
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
		
		private function get Things()
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
		
		public function ThingApp() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			btn_endTurn.addEventListener(MouseEvent.CLICK, function(e:*)
										 				   {
															   endTurn();
														   });
														   
			room2.lightSwitch.addEventListener("lightSwitched", function(e:*)
															    {
																    Things.forEach(function(thing:*) 
																				   {
																					   thing.refreshVisibility();
																				   });  
															    });
			
			GlobalState.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];			
			reachabilityMaps2AdjacencyLists(GlobalState.rooms);
			
			initializePlayers();
			initializeThing();	
			
			//paranoia = new Paranoia0(GlobalState.players);
			
		}		
		
		//todo: make look nicer
		private function reachabilityMaps2AdjacencyLists(rooms:Array)
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
		
		private function initializePlayers()
		{
			trace("Where do humans start?")
			var initialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;
		
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player(humanInfectedRefusalProbability);
				//player.revelationCallback = function(myplayer:Player, isInfected:Boolean){paranoia.considerEvidence(myplayer, isInfected)};
								
				GlobalState.rooms[3].putIn(player);
				stage.addChild(player);					
			}
		}
		
		private function initializeThing()
		{
			var thing = new Thing();
			
			//todo: needs refactoring
			trace("Where does", thing, "start?");
			//var thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;
			var thingsInitialRoom = 3;
			/*
			if(!GlobalState.rooms[thingsInitialRoom].IsTakenOver)
			{
				trace(thing, "needs another room to start?");
				thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length - 1, 0, thingsInitialRoom);
			}
			*/
			GlobalState.rooms[thingsInitialRoom].putIn(thing);
			stage.addChild(thing);
		}
		
		private function identifySquads()
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
		private function returnRandomSquadMember(squad:*)
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
		
		private function onKeyPress(e:KeyboardEvent)
		{
			//space
			if (e.keyCode == 32)
				endTurn();
			else if (String.fromCharCode(e.charCode) == "d")
				GlobalState.DEBUG = !GlobalState.DEBUG;
				//needs improvemen
		}
		
		private function endTurn()
		{						
			//test room gives out syringes
			room5.enhancePlayers();	
			
			//room4 gives out bombs
			room4.enhancePlayers();
			
			var squads = identifySquads();
			squads.forEach(function(squad:*) 
						   {
							   returnRandomSquadMember(squad)
						   });
			
			Players.forEach(function(item:*) {item.act()});
			Things.forEach(function(item:*) {item.act()});
			
			if(GlobalState.rooms.every(function(item:*) {return item.NonInfectedPlayers.length == 0}))
			{
				trace("HUMANS LOST");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		   
			}
			  
			 if(GlobalState.rooms.every(function(item:*) {return item.Things.length == 0 
															  && item.InfectedPlayers.length == 0}))
		   {
				trace("HUMANS WON");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		   }
		   
		   //reset action flags
		   Players.forEach(function(item:*){item.IsInactive = false});
			
			//paranoia.updateProbabilities();
			//trace(paranoia);
		}
		
	}
	
}
