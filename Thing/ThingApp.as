package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
	import Utils;
	import flashx.textLayout.formats.BackgroundColor;
	
	public class ThingApp extends MovieClip 
	{			
		const maxPlayers = 5;
		
		public function ThingApp() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onTurnEnd);
			
			GlobalState.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
			
			initializePlayers();
			initializeThing();	
		}		
		
		private function initializePlayers()
		{
			var initialRoom = Utils.getRandom(GlobalState.rooms.length - 1);
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player();
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
			var thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length - 1);
			if(!GlobalState.rooms[thingsInitialRoom].IsTakenOver)
			thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length - 1, 0, thingsInitialRoom);
			
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
			
			return squads;
		}
		
		private function returnRandomSquadMember(squad:*)
		{
			//return random players to their previous rooms
			var returnRandomPlayer:Function = function(item:*)
			{
				if(squad.length > 1 && Utils.getRandom(5) > 3)
				{
					var luckyMan:Player = squad[Utils.getRandom(item.length - 1)];
						luckyMan.previousRoom.putIn(luckyMan);
				}
			}			
		}
		
		private function onTurnEnd(e:KeyboardEvent)
		{			
		
			//test room gives out syringes
			room5.enhancePlayers();	
			
			var squads = identifySquads();			
			squads.forEach(function(item:*){returnRandomSquadMember(item)});
			
			GlobalState.players.forEach(function(item:*) {item.act()});
			GlobalState.things.forEach(function(item:*) {item.act()});
			
			if(GlobalState.rooms.every(function(item:*) {return item.Players.length == 0}))
			{
				trace("YOU LOST");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onTurnEnd);
		   
			}
			  
			 if(GlobalState.rooms.every(function(item:*)
										{return !item.characters.some(function(character:*)
																	  {return character is Thing || character.IsInfected})
										}))
		   {
				trace("YOU WON");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, onTurnEnd);
		   }
		   
		   //reset action flags
		   GlobalState.players.forEach(function(item:*){item.IsInactive = false});
			
		}
		
	}
	
}
