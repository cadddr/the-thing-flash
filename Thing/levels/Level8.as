package levels {

	import flash.display.MovieClip;
	import flash.events.*;
	import Utils;
	//import Paranoia0;
	import levels.LevelBase;
	//import flashx.textLayout.formats.BackgroundColor;

	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class Level8 extends LevelBase {
		//var paranoia: Paranoia0;

		public function Level8() {
			maxPlayers = 5;

			playerReachabilityMap = [
				[1, 0, 0, 0, 0, 0, 1, 1],
				[0, 1, 0, 0, 0, 0, 1, 0],
				[0, 0, 1, 0, 0, 0, 1, 0],
				[0, 0, 0, 1, 0, 0, 1, 0],
				[0, 0, 0, 0, 1, 0, 0, 1],
				[0, 0, 0, 0, 0, 1, 0, 1],
				[1, 1, 1, 1, 0, 0, 1, 1],
				[1, 0, 0, 0, 1, 1, 1, 1]
			];

			thingReachabilityMap = [
				[1, 1, 0, 0, 0, 0, 1, 1],
				[1, 1, 0, 0, 0, 0, 1, 1],
				[0, 0, 1, 1, 0, 1, 1, 1],
				[0, 0, 1, 1, 1, 0, 1, 1],
				[0, 0, 0, 1, 1, 1, 0, 1],
				[0, 0, 1, 0, 1, 1, 0, 1],
				[1, 1, 1, 1, 0, 0, 1, 1],
				[1, 1, 1, 1, 1, 1, 1, 1]
			];
		}

		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			// lightRoom = room2;

			super.onAddedToStage(e);
		}


		override protected function endTurn() {
			//test room gives out syringes
			room5.enhancePlayers();

			//room4 gives out bombs
			room4.enhancePlayers();
			
			super.endTurn();
		}
	}
}