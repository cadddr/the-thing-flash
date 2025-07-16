package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	import Utils;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	import Math;
	
	public class AsciiLevel3 extends LevelBase {
		
		public function AsciiLevel3() {
			maxPlayers = 2;
			initialRoom = 0;
			
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
	
			room31.stop();
			room31.cockpit.stop();

			// camera.pinCameraToObject(room31, room31.width / 2, room31.height / 2);	
			Utils.tweenValueAndFinish({"x":0}, "x", Regular.easeInOut, room31.x, room37.x, 2.,
				function (e:*) {
					camera.pinCameraToObject(room37, e.position - room37.x, 0);
				},
				function (e:*) {
					GlobalState.announce("We need to reach the generator.");
					// camera.pinCameraToObject(room37, 0, 0);
					Utils.tweenValueAndFinish({"x":0}, "x", Regular.easeInOut, room37.x, room31.x, 2.,
					function (e:*) {
						camera.pinCameraToObject(room31, e.position - room31.x, (room37.y - room31.y));
					},
					function (e:*) {
						// camera.pinCameraToObject(room31, 0, 0);	
					});
				});
		}
	}
}
