package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
		
	public class ThingApp extends MovieClip {			
								  
		var rooms : Array = [];
		var players : Vector.<MovieClip> = new Vector.<MovieClip>();
		const maxPlayers = 7;
		
		public function ThingApp() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{
			//so that we could undrag the player
			stage.addEventListener(MouseEvent.MOUSE_UP, monMouseUp);			
			
			rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
			var initialRoomNumber = Math.round(Math.random() * (rooms.length - 1));
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player(String.fromCharCode(97 + i));
				
				stage.addChild(player);		
				rooms[initialRoomNumber].putIn(player);
				players.push(player);
			}
		}	
		
		private function monMouseUp(e:MouseEvent) : void
		{			
			if(Globals.draggableCharacter != null)
			{
				Globals.draggableCharacter.stopDrag();
				Globals.draggableCharacter.mouseEnabled = true;
			    Globals.draggableCharacter = null;
			}
		}
		
		
	}
	
}
