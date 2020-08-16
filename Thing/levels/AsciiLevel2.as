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
			
			var callback = function (e: * ): void {
				Things.forEach(function (thing: * ) {
					thing.refreshVisibility();
				});
			};

			room1.passiveAbility = function (room:RoomBase):void
			{			
				var eligiblePlayers = room.guests.filter(function(item:*) {
					return item is Player && !item.IsInactive
				});
				
				eligiblePlayers.forEach(function(item:*) {item.equipExplosiveCharge()});
			}

			room5.passiveAbility = function (room:RoomBase):void
			{			
				var eligiblePlayers = room.guests.filter(function(item:*) {
					return item is Player && !item.IsInactive
				});
				
				eligiblePlayers.forEach(function(item:*) {item.equipSyringe()});
			}

			room9.spawnLightSwitch(cameraLayer, callback); 
			room13.spawnLightSwitch(cameraLayer, callback); 

			super.onAddedToStage(e);
			
		}

		override protected function endTurn() {
			room1.enhancePlayers();
			room5.enhancePlayers();

			super.endTurn();
		}
	}	
}
