package rooms {
	
	import flash.display.MovieClip;
	import rooms.Room;
	import characters.Player;
	
	
	public class TestRoom extends Room {
		
		
		public function TestRoom() {
			// constructor code
		}
		
		override public function enhancePlayers()
		{			
			var eligiblePlayers = this.guests.filter(function(item:*) {return item is Player && !item.IsInactive});
			
			eligiblePlayers.forEach(function(item:*) {item.equipSyringe()});
		}
	}
	
}
