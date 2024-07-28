package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	
	public class AsciiLevel3 extends LevelBase {
		
		public function AsciiLevel3() {
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
			return [room31, room32, room33, room34];
		}
	}
}
