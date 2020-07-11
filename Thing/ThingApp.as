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
		const maxPlayers = 5;
		var paranoia:Paranoia0;
		
		public function ThingApp() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			
			GlobalState.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];			
			
			initializePlayers();
			initializeThing();	
			
			paranoia = new Paranoia0(GlobalState.players);
			
		}		
		
		private function initializePlayers()
		{
			trace("Where do humans start?")
			var initialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player();
				player.revelationCallback = function(myplayer:Player, isInfected:Boolean){paranoia.considerEvidence(myplayer, isInfected)};
				
				GlobalState.players.push(player);
				
				GlobalState.rooms[initialRoom].putIn(player);
				stage.addChild(player);					
			}
		}
		
		private function initializeThing()
		{
			var thing = new Thing();
			GlobalState.things.push(thing);
			
			//needs refactoring
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
		
		private function identifySquads()
		{
			var squads:Array = [];
			var checkedSquadMembers:Array = [];
			
			for (var i:int = 0; i < GlobalState.players.length; i++)
			{				
				//identifying squads of players moving together
				var checkSameSquad:Function = function(item:*)
				{
					 return item.previousRoom == GlobalState.players[i].previousRoom
						 && item.currentRoom == GlobalState.players[i].currentRoom
						 && item.currentRoom != GlobalState.players[i].previousRoom
						 && item.previousRoom != GlobalState.players[i].currentRoom
						 && item.IsInactive;
				}
				
				if (!checkedSquadMembers.some(checkSameSquad)
					&& GlobalState.players[i].IsInactive)
				{
					var squad:Array = GlobalState.players.filter(checkSameSquad);
					
					squads.push(squad);
					//so we wouldn't consider members of the same squad twice
					checkedSquadMembers.push(GlobalState.players[i]);
				}
			}			
			
			return squads.filter(function(squad:*) {return squad.length > 1});
		}
		
		//return random players to their previous rooms
		private function returnRandomSquadMember(squad:*)
		{
			trace("Squad: [", squad, "]");
			trace("Will someone get left behind?");
			if(Utils.getRandom(6, 1) <= GlobalState.leftBehindProbability)
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
			squads.forEach(function(squad:*) {returnRandomSquadMember(squad)});
			
			GlobalState.players.forEach(function(item:*) {item.act()});
			GlobalState.things.forEach(function(item:*) {item.act()});
			
			if(GlobalState.rooms.every(function(item:*) {return item.Players.length == 0}))
			{
				trace("HUMANS LOST");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		   
			}
			  
			 if(GlobalState.rooms.every(function(item:*)
										{return !item.characters.some(function(character:*)
																	  {return character is Thing || character.IsInfected})
										}))
		   {
				trace("HUMANS WON");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
		   }
		   
		   //reset action flags
		   GlobalState.players.forEach(function(item:*){item.IsInactive = false});
			
			paranoia.updateProbabilities();
			trace(paranoia);
		}
		
	}
	
}
