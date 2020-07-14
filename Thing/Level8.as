package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
	import Utils;
	import Paranoia0;
	import levels.LevelBase;
	//import flashx.textLayout.formats.BackgroundColor;
	
	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class Level8 extends LevelBase 
	{			
		var paranoia:Paranoia0;
		
		public function Level8() 
		{
			trace("Level8");
			
			maxPlayers = 5;	
		
			playerReachabilityMap = [[1, 0, 0, 0, 0, 0, 1, 1],
									[0, 1, 0, 0, 0, 0, 1, 0],
									[0, 0, 1, 0, 0, 0, 1, 0],
									[0, 0, 0, 1, 0, 0, 1, 0],
									[0, 0, 0, 0, 1, 0, 0, 1],
									[0, 0, 0, 0, 0, 1, 0, 1],
									[1, 1, 1, 1, 0, 0, 1, 1],
									[1, 0, 0, 0, 1, 1, 1, 1]];
													
			thingReachabilityMap = [[1, 1, 0, 0, 0, 0, 1, 1],
								  [1, 1, 0, 0, 0, 0, 1, 1],
								  [0, 0, 1, 1, 0, 1, 1, 1],
								  [0, 0, 1, 1, 1, 0, 1, 1],
								  [0, 0, 0, 1, 1, 1, 0, 1],
								  [0, 0, 1, 0, 1, 1, 0, 1],
								  [1, 1, 1, 1, 0, 0, 1, 1],
								  [1, 1, 1, 1, 1, 1, 1, 1]];
								  
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
		
		
		override protected function endTurn()
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
