package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.*
	import characters.*
	
	
	public class AsciiTestRoom extends AsciiSmallSquareRoom {
		
		
		public function AsciiTestRoom() {
			asciiFloor = room.asciiFloor;
			room.disableAllInteraction();
		}

		public function enhancePlayers()
		{			
			var eligiblePlayers = this.guests.filter(function(item:*) {
				return item is Player && !item.IsInactive
			});
			
			eligiblePlayers.forEach(function(item:*) {item.equipSyringe()});
		}
	}
	
}
