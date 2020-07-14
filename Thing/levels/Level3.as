package levels {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import GlobalState;
	
	public class Level3 extends LevelBase {
		
		public function Level3() {
			maxPlayers = 4;
			
			playerReachabilityMap = [
				[1, 1, 0, 0, 0, 0, 0, 0, 0],
				[1, 1, 1, 0, 0, 0, 0, 0, 0],
				[0, 1, 1, 0, 1, 1, 0, 1, 0],
				[0, 0, 0, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 0, 0, 1, 1, 0, 0],
				[0, 0, 0, 0, 0, 1, 1, 0, 0],
				[0, 0, 1, 0, 0, 0, 0, 1, 1],
			    [0, 0, 1, 0, 0, 0, 0, 1, 1]
			];

			thingReachabilityMap = [
				[1, 1, 0, 0, 0, 0, 0, 0, 0],
				[1, 1, 1, 0, 0, 0, 0, 0, 0],
				[0, 1, 1, 0, 1, 1, 0, 1, 0],
				[0, 0, 0, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 0, 0, 1, 1, 0, 0],
				[0, 0, 0, 0, 0, 1, 1, 0, 0],
				[0, 0, 1, 0, 0, 0, 0, 1, 1],
			    [0, 0, 1, 0, 0, 0, 0, 1, 1]
			];
		}
		
		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room3, room2, room1_2, room6, room5, room1_3, room4, room1_4];
			lightRoom = room2;
			
			super.onAddedToStage(e);
		}

		override protected function endTurn() {
			room4.enhancePlayers();
			room5.enhancePlayers();

			super.endTurn();
		}
	}
	
}
