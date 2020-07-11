package  {
	
	import flash.display.MovieClip;
	import Room;
	
	
	public class TestRoom extends Room {
		
		
		public function TestRoom() {
			// constructor code
		}
		
		public function enhancePlayers()
		{			
			var eligiblePlayers = this.characters.filter(function(item:*) {return item is Player && !item.IsInactive});
			
			eligiblePlayers.forEach(function(item:*) {item.equipSyringe()});
		}
	}
	
}
