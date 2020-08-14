package levels {

	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import GlobalState;

	public class Level1 extends LevelBase {

		public function Level1() {
			maxPlayers = 2;
			
			playerReachabilityMap = 
			[
				[1, 0, 1],
				[0, 1, 1],
				[1, 1, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 0, 1],
				[0, 1, 1],
				[1, 1, 1]
			];
		}

		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room2, room3];
			// lightRoom = room2;
			
			super.onAddedToStage(e);
		}
	}
}