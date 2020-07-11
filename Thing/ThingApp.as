package  {
	
	import flash.display.MovieClip;
	import flash.events.*; 
		
	public class ThingApp extends MovieClip {			
								  
		var players : Array = [];
		const maxPlayers = 7;
		
		public function ThingApp() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage(e:Event) : void 
		{			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onTurnEnd);
			
			Globals.rooms = [room1, room2, room3, room4, room5, room6, room7, room8];
			
			var initialRoom = Math.round(Math.random() * (Globals.rooms.length - 1));
			
			for (var i:int = 0; i < maxPlayers; i++)
			{
				var player = new Player();
				
				stage.addChild(player);		
				Globals.rooms[initialRoom].putIn(player);
				players.push(player);
			}
		}		
		
		private function onTurnEnd(e:KeyboardEvent)
		{
			//reset action flags
			for (var i:int = 0; i < players.length; i++)
			{
				players[i].IsInactive = false;
			}
		}
		
	}
	
}
