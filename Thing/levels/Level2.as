package levels {

	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import GlobalState;

	public class Level2 extends LevelBase {

		public function Level2() {
			maxPlayers = 3;

			playerReachabilityMap = [
				[1, 1, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 0, 0, 0, 0, 0],
				[0, 1, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 1, 1, 0, 0, 0],
				[0, 0, 0, 1, 1, 1, 0, 0],
				[0, 0, 0, 0, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 1, 1]
			];

			thingReachabilityMap = [
				[1, 1, 0, 0, 0, 0, 0, 1],
				[1, 1, 1, 0, 0, 0, 0, 0],
				[0, 1, 1, 1, 0, 0, 0, 0],
				[0, 0, 1, 1, 1, 0, 0, 0],
				[0, 0, 0, 1, 1, 1, 0, 0],
				[0, 0, 0, 0, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 1, 1, 1],
				[1, 0, 0, 0, 0, 0, 1, 1]
			];
		}

		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room3, room2, room4, room1_2, room3_2, room1_3, room4_2];
			// lightRoom = room2;
			
			super.onAddedToStage(e);
		}

		override protected function endTurn() {
			room4.enhancePlayers();
			room4_2.enhancePlayers();

			super.endTurn();
		}
	}

}