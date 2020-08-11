package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	import asciiRooms.AsciiSmallSquareRoom;
	
	
	public class AsciiLevel2 extends LevelBase {
		
		
		public function AsciiLevel2() {
			playerType = AsciiPlayer;
			thingType = AsciiThing;

			GlobalState.thingType = thingType;
			
			maxPlayers = 3;
			
			playerReachabilityMap = 
			[
				[1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			    [0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
				[0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			    [0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0],
				[0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1],
				[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
			];
		}

		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room2, room3, room4, room5,
			                     room6, room7, room8, room9,
								 room10, room11, room12, room13];
			
			super.onAddedToStage(e);
			
		}
	}	
}
