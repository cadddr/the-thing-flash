package  {
	import flash.display.MovieClip;
	import Room;
	public class GlobalState {

		public static var DEBUG:Boolean = false;
		//out of 6
		public static var leftBehindProbability:Number = 5
		public static var humanKillingProbability:Number = 2;
		public static var thingKillingProbability:Number = 3;
		
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
