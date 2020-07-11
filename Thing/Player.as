package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
	import Globals;
	
	public class Player extends MovieClip {		
		
		var alreadyActed:Boolean;
		public var currentRoom:Room;
		
		public function Player() {			
			
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			// mouse up handled by stage
			
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, function() {gotoAndPlay(2)});
			addEventListener(MouseEvent.MOUSE_OUT, function() {gotoAndStop(1)});
			
			
			alreadyActed = false;
			currentRoom = null;
			
			this.transform.colorTransform = new ColorTransform(0, 0, 0, 1, Math.random() * 255, Math.random() * 255, Math.random() * 255);
		}
		
		function onMouseDown(e:MouseEvent)
		{
			if(!alreadyActed)
			{
				highlightReachableRooms();
				startDrag();			
				mouseEnabled = false;
				Globals.draggableCharacter = this;	
			}
		}
		
		private function highlightReachableRooms()
		{
			var originRoomIndex:int = 0;
			
			if (currentRoom is Room1)
				originRoomIndex = 0			
			
			else if (currentRoom is GenRoom)
				originRoomIndex = 1
				
			else if (currentRoom is Room3)
				originRoomIndex = 2
				
			else if (currentRoom is AmmoRoom)
				originRoomIndex = 3
			
			else if (currentRoom is TestRoom)
				originRoomIndex = 4
				
			else if (currentRoom is Room6)
				originRoomIndex = 5
				
			else if (currentRoom is Room7)
				originRoomIndex = 6
				
			else if (currentRoom is Room8)
				originRoomIndex = 7;
			
			
			var passabilityList = Globals.passabilityMap[originRoomIndex];
								
				for(var i:int = 0; i < passabilityList.length; i++)
				{
					if (passabilityList[i] == 1)
						
						Globals.rooms[i].gotoAndStop(3);
				}
			}
		
		
	}
	
}
