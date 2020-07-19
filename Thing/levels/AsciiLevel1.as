package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	
	
	public class AsciiLevel1 extends LevelBase {
		
		
		public function AsciiLevel1() {
			playerType = AsciiPlayer;
			thingType = AsciiThing;
			
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

		override protected function onAddedToStage(e: Event): void {
			GlobalState.rooms = [room1, room2, room3, room4];
/*			room2.lightSwitch = new AsciiGeneratorSwitch();
			stage.addChild(room2.lightSwitch);*/
			
			//lightRoom = room2
			
			super.onAddedToStage(e);
		}
	}
	
}
