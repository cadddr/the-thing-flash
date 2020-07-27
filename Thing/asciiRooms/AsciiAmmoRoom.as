package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.AmmoRoom;
	import asciiRooms.*;
	import characters.*;
	
	
	public class AsciiAmmoRoom extends AsciiSmallSquareRoom {
		
		
		public function AsciiAmmoRoom() {
			// asciiFloor = room.asciiFloor;
			room.disableAllInteraction();
		}

		public function enhancePlayers()
		{			
			var eligiblePlayers = this.guests.filter(function(item:*) {
				return item is Player && !item.IsInactive
			});
			
			eligiblePlayers.forEach(function(item:*) {item.equipExplosiveCharge()});
		}
	}
	
}
