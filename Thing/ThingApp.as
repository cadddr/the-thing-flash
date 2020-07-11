package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
		
	public class ThingApp extends MovieClip {
		
		var passabilityMap : Array = [[0, 0, 0, 0, 0, 0, 1, 1],
								  [0, 0, 0, 0, 0, 0, 1, 0],
								  [0, 0, 0, 0, 0, 0, 1, 0],
								  [0, 0, 0, 0, 0, 0, 1, 0],
								  [0, 0, 0, 0, 0, 0, 0, 1],
								  [0, 0, 0, 0, 0, 0, 0, 1],
								  [1, 1, 1, 1, 0, 0, 0, 1],
								  [0, 0, 0, 0, 1, 1, 1, 0]];
								  
		var rooms : Array = [];
		var redPlayers : Vector.<MovieClip> = new Vector.<MovieClip>();
		const maxPlayers = 7;
		
		public function ThingApp() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
			
		}
		
		private function onAddedToStage(e:Event) : void 
		{
			this.stage.addEventListener(MouseEvent.MOUSE_UP, monMouseUp);
			
			rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player(String.fromCharCode(97 + i));
				
				redPlayers.push(player);
				parent.addChild(player);
				
				rooms[7].PutInCorridor8(player, rooms[7]);
			}
			
			var roomNumber = Math.round(Math.random() * (rooms.length - 1));
			
			trace(roomNumber + 1);
			//PutInRoom(redPlayer, rooms[roomNumber]);
		}
		
		private function monMouseUp(event : MouseEvent) : void
		{
			var draggableCharacter = Globals.draggableCharacter as Player;
			if(draggableCharacter != null)
			{
				draggableCharacter.stopDrag();
				draggableCharacter.mouseEnabled = true;
				Globals.draggableCharacter = null;
			}
		}
		
		// puts a character at a random location within a specified room
		
		
		
	}
	
}
