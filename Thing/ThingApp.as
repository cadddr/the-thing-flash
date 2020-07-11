package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
	import Utils;
	public class ThingApp extends MovieClip {			
								  
		var players : Array = [];
		const maxPlayers = 7;
		
		public function ThingApp() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onTurnEnd);
			
			GlobalState.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
		
			initializeThing();	
			
			initializePlayers();
		}		
		
		private function initializePlayers()
		{
			var initialRoom = Utils.getRandom(GlobalState.rooms.length - 1);
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player();
				
				stage.addChild(player);		
				GlobalState.rooms[initialRoom].putIn(player);
				players.push(player);
			}
		}
		
		private function initializeThing()
		{
			var thing = new Thing();
			GlobalState.things.push(thing);
			
			var thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length - 1);
			
			GlobalState.rooms[thingsInitialRoom].putIn(thing);
			stage.addChild(thing);
		}
		
		private function onTurnEnd(e:KeyboardEvent)
		{			
			var squads:Array = [];
			var checkedSquadMembers:Array = [];
			
			for (var i:int = 0; i < players.length; i++)
			{				
				//identifying squads of players moving together
				var checkSameSquad:Function = function(item:*)
				{
					 return item.previousRoom == players[i].previousRoom
						 && item.currentRoom == players[i].currentRoom
						 && item.currentRoom != players[i].previousRoom
						 && item.previousRoom != players[i].currentRoom
						 && item.IsInactive;
				}
				
				if (!checkedSquadMembers.some(checkSameSquad)
					&& players[i].IsInactive)
				{
					var squad:Array = players.filter(checkSameSquad);
					
					squads.push(squad);
					//so we wouldn't consider members of the same squad twice
					checkedSquadMembers.push(players[i]);
				}
				///////////////////////////////////////////////////////////
				
				//reset action flags			
				players[i].IsInactive = false;
			}			
			
			//return random players to their previous rooms
			var returnRandomPlayer:Function = function(item:*)
			{
				if(item.length > 1 && Utils.getRandom(5) > 3)
				{
					var luckyMan:Player = item[Utils.getRandom(item.length - 1)];
						luckyMan.previousRoom.putIn(luckyMan);
				}
			}			
			
			squads.forEach(returnRandomPlayer);
			
			GlobalState.things.forEach(function(item:*) {item.act()});
			players.forEach(function(item:*) {item.selfact()});
		}
		
	}
	
}
