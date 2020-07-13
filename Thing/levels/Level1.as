package levels {
	
	import flash.display.MovieClip;
	import flash.events.*; 
	import levels.LevelBase;
	import GlobalState;
	
	public class Level1 extends LevelBase {
		
		
		
		public function Level1() 
		{
			trace ("Level1");
            maxPlayers = 2;	
			playerReachabilityMap  = [[1, 0, 1],
									  [0, 1, 1],
									  [1, 1, 1]];
													
			thingReachabilityMap = [[1, 0, 1],
								    [0, 1, 1],
									[1, 1, 1]];
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{			
			trace("onAddedToStage");
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
			btn_endTurn.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {endTurn();});
														   
			room2.lightSwitch.addEventListener("lightSwitched", function(e:*) {
				Things.forEach(function(thing:*) {thing.refreshVisibility();});  
			});
			
			GlobalState.rooms = [room1, room2, room3];			
			reachabilityMaps2AdjacencyLists(GlobalState.rooms);
			
			initializePlayers();
			initializeThing();	
			trace("Rooms", GlobalState.rooms);
		}	
		override protected function endTurn()
		{									
			trace("endTurn");
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
			
		}
	}
	
}
