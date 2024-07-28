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
				[1, 1, 0, 0, 0, 0, 0],
				[1, 1, 1, 0, 0, 0, 0],
			    [0, 1, 1, 1, 1, 0, 0],
				[0, 0, 1, 1, 0, 1, 0],
                [0, 0, 1, 0, 1, 1, 0],
                [0, 0, 0, 1, 1, 1, 1],
                [0, 0, 0, 0, 0, 1, 1],
			];
			
			thingReachabilityMap = 
			[
				[1, 1, 0, 0, 0, 0, 0],
				[1, 1, 1, 0, 0, 0, 0],
			    [0, 1, 1, 1, 1, 1, 0],
				[0, 0, 1, 1, 0, 1, 0],
                [0, 0, 1, 0, 1, 1, 0],
                [0, 0, 1, 1, 1, 1, 1],
                [0, 0, 0, 0, 0, 1, 1],
			];
		}

		override protected function get Rooms(): Array {
			return [room31, room32, room33, room34, room35, room36, room37];
		}

		override protected function onAddedToStage(e: Event): void {
			// room37.spawnInteractable(new AsciiGeneratorSwitch(), cameraLayer); 
			room37.interactables.push(room37.asciiGeneratorSwitch)
			super.onAddedToStage(e);
		}
	}
}
