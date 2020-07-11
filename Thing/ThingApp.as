package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
		
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
			
			Globals.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
			var initialRoom = Math.round(Math.random() * (Globals.rooms.length - 1));
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player();
				
				stage.addChild(player);		
				Globals.rooms[initialRoom].putIn(player);
				players.push(player);
			}
		}		
		
		private function onTurnEnd(e:KeyboardEvent)
		{			
			//return random players to their previous rooms
			var squads:Array = [];
			var checkedSquadMembers:Array = [];
			
			for (var i:int = 0; i < players.length; i++)
			{				
				var checkSameSquad:Function = function(item:*)
				{
					 return item.previousRoom == players[i].previousRoom
						 && item.currentRoom == players[i].currentRoom
						 && item.currentRoom != players[i].previousRoom
						 && item.previousRoom != players[i].currentRoom;
				}
				
				if (!checkedSquadMembers.some(checkSameSquad)
					&& players[i].IsInactive)
					
				{
					
					var squad:Array = players.filter(checkSameSquad);
					
					trace(i, squads);
					//var checkDuplicateSquads:Function = function(item:*)
					//{
					//	return item.some(function(item2:*) {squad.indexOf(item2) == -1})
					//}
					
					//if (!squads.some(checkDuplicateSquads))
					squads.push(squad);			
					checkedSquadMembers.push(players[i]);
				}
				
				//reset action flags			
				players[i].IsInactive = false;
			}			
			
			
			var returnRandomPlayer:Function = function(item:*)
			{
				if(item.length > 1 && Math.round(Math.random() * 5) > 3)
				{
					var luckyMan:Player = item[Math.round(Math.random() * (item.length - 1))];
						luckyMan.previousRoom.putIn(luckyMan);
				}
			}			
			
			squads.forEach(returnRandomPlayer);
			
			
		}
		
	}
	
}
