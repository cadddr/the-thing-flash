package rooms {
	
	import flash.display.MovieClip;
	import rooms.Room;
	import characters.Player;
	
	public class AmmoRoom extends Room {
		
		
		public function AmmoRoom() {
			// constructor code
		}
		
		public function enhancePlayers()
		{			
			var eligiblePlayers = this.guests.filter(function(item:*) {return item is Player && !item.IsInactive});
			
			eligiblePlayers.forEach(function(item:*) {item.equipExplosiveCharge()});
		}
	}
	
}
