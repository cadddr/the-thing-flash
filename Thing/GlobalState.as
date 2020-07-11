package  {
	import flash.display.MovieClip;
	import Room;
	public class GlobalState {

		public static var DEBUG:Boolean = false;
		
		public static var rooms:Array;
		public static var things:Array = [];
		public static var players:Array = [];
		public static var draggableCharacter:Player;
		public static var isLightOn:Boolean = true;
		public static var passabilityMap : Array = [[1, 0, 0, 0, 0, 0, 1, 1],
								  					[0, 1, 0, 0, 0, 0, 1, 0],
								  					[0, 0, 1, 0, 0, 0, 1, 0],
								  					[0, 0, 0, 1, 0, 0, 1, 0],
								  					[0, 0, 0, 0, 1, 0, 0, 1],
								 					[0, 0, 0, 0, 0, 1, 0, 1],
								  					[1, 1, 1, 1, 0, 0, 1, 1],
								  					[1, 0, 0, 0, 1, 1, 1, 1]];
													
		public static var adjacencyMap : Array = [[1, 1, 0, 0, 0, 0, 1, 1],
								  				  [1, 1, 0, 0, 0, 0, 1, 1],
								  				  [0, 0, 1, 1, 0, 1, 1, 1],
								  				  [0, 0, 1, 1, 1, 0, 1, 1],
								  			      [0, 0, 0, 1, 1, 1, 0, 1],
								 				  [0, 0, 1, 0, 1, 1, 0, 1],
								  				  [1, 1, 1, 1, 0, 0, 1, 1],
								  				  [1, 1, 1, 1, 1, 1, 1, 1]];
												  
		public static var reachableRooms:Array = [];
		
			
	}
	
}
