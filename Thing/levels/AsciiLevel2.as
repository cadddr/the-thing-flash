package levels {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import levels.LevelBase
	import characters.*;
	import items.*;
	import asciiRooms.AsciiSmallSquareRoom;
	import items.AsciiGeneratorSwitch;
	import rooms.RoomBase;
	import effects.AsciiParticleSystem;
	
	
	public class AsciiLevel2 extends LevelBase {
		
		
		public function AsciiLevel2() {
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

		override protected function get Rooms(): Array {
			return [room1, room2, room3, room4, room5,
			         room6, room7, room8, room9,
					 room10, room11, room12, room13];
		}

		// initialization requiring MovieClip objects
		override protected function onAddedToStage(e: Event): void {
			// rooms = [room1, room2, room3, room4, room5,
			//          room6, room7, room8, room9,
			// 		 room10, room11, room12, room13];

			room1.passiveAbility = RoomBase.PASSIVE_ABILITY_DISPENSE_EXPLOSIVES
			room5.passiveAbility = RoomBase.PASSIVE_ABILITY_DISPENSE_SYRINGES

			room9.spawnInteractable(new AsciiGeneratorSwitch(), cameraLayer); 
			room13.spawnInteractable(new AsciiGeneratorSwitch(), cameraLayer); 

			super.onAddedToStage(e);
		}

		override public function endTurn() {
			room1.enhancePlayers();
			room5.enhancePlayers();

			super.endTurn();
		}
	}	
}
