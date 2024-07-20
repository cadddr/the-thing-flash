package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	
	public class AsciiLevel1 extends LevelBase {
		
		
		public function AsciiLevel1() {
			maxPlayers = 2;
			
			playerReachabilityMap = 
			[
				[1, 1, 1, 0],
				[1, 1, 0, 1],
			    [1, 0, 1, 1],
				[0, 1, 1, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 1, 1, 0],
				[1, 1, 0, 1],
			    [1, 0, 1, 1],
				[0, 1, 1, 1]
			];
			
		}

		override protected function get Rooms(): Array {
			return [room1, room2, room3, room4];
		}

		override protected function onAddedToStage(e: Event): void {
			// GlobalState.rooms = [room1, room2, room3, room4];
			
			super.onAddedToStage(e);
			
		}

		override public function endTurn() {
			room1.enhancePlayers();
			room4.enhancePlayers();

			super.endTurn();
		}
	}
	
}
