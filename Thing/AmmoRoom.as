package  {
	
	import flash.display.MovieClip;
	import Room;
	
	public class AmmoRoom extends Room {
		
		
		public function AmmoRoom() {
			// constructor code
		}
		
		public function enhancePlayers()
		{			
			var eligiblePlayers = this.Players.filter(function(item:*) {return !item.IsInactive});
			
			eligiblePlayers.forEach(function(item:*) {item.equipExplosiveCharge()});
		}
	}
	
}
