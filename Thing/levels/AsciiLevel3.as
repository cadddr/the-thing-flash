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
	import characters.Player;
	import asciiRooms.AsciiRoomBase;
	
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
			GlobalState.announce("We need to reach the generator.");

			Utils.tweenValueAndFinish({"x":0}, "x", Regular.easeInOut, room31.x, room37.x, 2.,
				function (e:*) {
					camera.pinCameraToObject(room37, e.position - room37.x, 0);
				},
				function (e:*) {
					AsciiRoomBase(room37).applyTileLightingFromSource(
						room37, 
						room37.x + room37.asciiGeneratorSwitch.x - GlobalState.TILE_WIDTH / 2, 
						room37.y + room37.asciiGeneratorSwitch.y - GlobalState.TILE_HEIGHT / 2
					);
					// camera.pinCameraToObject(room37, 0, 0);
					Utils.tweenValueAndFinish({"x":0}, "x", Regular.easeOut, room37.x, room31.x, 2.,
					function (e:*) {
						camera.pinCameraToObject(room31, e.position - room31.x, (room37.y - room31.y));
					},
					function (e:*) {
						GlobalState.announce("Let's make our way, one room at a time.");
						// camera.pinCameraToObject(room31, 0, 0);	
					});
				}
			);

			Things.forEach(function (thing: * ) {
				thing.addEventListener(GlobalState.THING_REVEALED, function (e:*) {
					if (e.visible) {
						GlobalState.announce("Holy shit, what is that THING?!");
					}
					else {
						GlobalState.announce("Where did it go???");
					}
				});
			});

			room31.addEventListener(GlobalState.CHARACTER_PLACED_IN_ROOM, function (e:*) {
				if (e.character is Player) {
					GlobalState.announce("Nice, we're out of here!");
				}
			});

			room32.addEventListener(GlobalState.CHARACTER_PLACED_IN_ROOM, function (e:*) {
				if (e.character is Player) {
					GlobalState.announce("So far so good. Let's keep going.");
				}
			});

			room33.addEventListener(GlobalState.CHARACTER_PLACED_IN_ROOM, function (e:*) {
				if (e.character is Player) {
					GlobalState.announce("Front door is blocked. We have to go around.");
				}
			});

			room37.addEventListener(GlobalState.CHARACTER_PLACED_IN_ROOM, function (e:*) {
				if (e.character is Player) {
					GlobalState.announce("Ok, now trip that switch.");
				}
			});

			room37.asciiGeneratorSwitch.addEventListener(GlobalState.LIGHT_SWITCHED, function (e:*) {
				if (e.character is Player) {
					GlobalState.announce("Done. Now let's head back to the ship.");
				}
				else {
					GlobalState.announce("What just happened, I can't see shit!");
				}
			});

			addEventListener(GlobalState.THING_DIED, function (e:*) {
				GlobalState.announce("Go to hell, you MOTHERFUCKER!!!");
			});
		}
	}
}
