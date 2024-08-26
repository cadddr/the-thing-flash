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
				[1, 0],
				[0, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 0],
				[0, 1]
			];
		}

		override protected function get Rooms(): Array {
			return [room1, room2];
		}
	}
}
