package rooms {
	
	import flash.display.MovieClip;
	import rooms.RoomBase;
	import characters.Player;
	
	public class AmmoRoom extends RoomBase {
		
		
		public function AmmoRoom() {
			// constructor code
		}
		
		override public function enhancePlayers()
		{			
			var eligiblePlayers = this.guests.filter(function(item:*) {return item is Player && !item.IsInactive});
			
			eligiblePlayers.forEach(function(item:*) {item.equipExplosiveCharge()});
		}
	}
	
}
