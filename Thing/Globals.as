package  {
	import flash.display.MovieClip;
	import Room;
	public class Globals {

		public static var rooms : Array;
		public static var reachableRooms:Array = [];
		public static var things:Array = [];
		public static var draggableCharacter : Object;
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
			
	}
	
}
