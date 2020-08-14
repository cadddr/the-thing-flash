package levels {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import GlobalState;
	import characters.Player;
	
	
	public class Level4 extends LevelBase {
		
		public function Level4() {
			maxPlayers = 13;
			
			playerReachabilityMap = 
			[
				[1, 0, 1, 0, 0, 0, 0, 0],
				[0, 1, 1, 0, 0, 0, 0, 0],
				[1, 1, 1, 1, 1, 0, 0, 0],
				[0, 0, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 0, 1, 1, 0, 1],
				[0, 0, 0, 0, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 1, 1, 0],
				[0, 0, 0, 0, 1, 0, 0, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 0, 1, 0, 0, 0, 0, 0],
				[0, 1, 1, 0, 0, 0, 0, 0],
				[1, 1, 1, 1, 1, 0, 0, 0],
				[0, 0, 1, 1, 1, 1, 0, 0],
				[0, 0, 1, 1, 1, 1, 0, 1],
				[0, 0, 0, 1, 1, 1, 1, 1],
				[0, 0, 0, 0, 0, 1, 1, 0],
				[0, 0, 0, 1, 1, 0, 0, 1]
			];
		}
		
		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room1_2, room3, room3_2, room3_3, room3_4, room2, room5];
			// lightRoom = room2;
			
			super.onAddedToStage(e);
		}
		
		override protected function initializePlayers() {
			for (var i: int = 0; i < maxPlayers; i++) {
				var player = new Player(humanInfectedRefusalProbability);
				
				if (room1.guests.length==0){
						room1.register(player);
						stage.addChild(player);
						continue;
				}
				
				if (room1_2.guests.length==0){
						room1_2.register(player);
					stage.addChild(player);
						continue;
				}
				
				if (room2.guests.length==0){
						room2.register(player);
					stage.addChild(player);
						continue;
				}
				
				if (room5.guests.length==0){
						room5.register(player);
					stage.addChild(player);
						continue;
				}
				
				if (i % 2 == 0) {
					room3_2.register(player);
				}
				

				if (i % 2 != 0) {
					room3_4.register(player);
				}
				
				
				stage.addChild(player);
			}
		}
		
		override protected function endTurn() {
			//test room gives out syringes
			room5.enhancePlayers();
			
			super.endTurn();
		}
	}
	
}
