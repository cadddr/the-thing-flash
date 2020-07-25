package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	
	
	public class AsciiLevel2 extends LevelBase {
		
		
		public function AsciiLevel2() {
			playerType = AsciiPlayer;
			thingType = AsciiThing;

			GlobalState.thingType = thingType;
			
			maxPlayers = 3;
			
			playerReachabilityMap = 
			[
				[1, 1, 0, 0, 0],
				[1, 1, 1, 0, 0],
			    [0, 1, 1, 1, 0],
				[0, 0, 1, 1, 1],
				[0, 0, 0, 1, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 1, 0, 0, 0],
				[1, 1, 1, 0, 0],
			    [0, 1, 1, 1, 0],
				[0, 0, 1, 1, 1],
				[0, 0, 0, 1, 1]
			];
		}

		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room2, room3, room4, room5];
			
			super.onAddedToStage(e);
			
		}
	}	
}
