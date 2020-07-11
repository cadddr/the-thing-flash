package  {
	import flash.display.MovieClip;
	import Room;
	public class GlobalState {
		
		public static var DEBUG:Boolean = true;
		
		public static const playerReachabilityMap : Array = [[1, 0, 0, 0, 0, 0, 1, 1],
															[0, 1, 0, 0, 0, 0, 1, 0],
															[0, 0, 1, 0, 0, 0, 1, 0],
															[0, 0, 0, 1, 0, 0, 1, 0],
															[0, 0, 0, 0, 1, 0, 0, 1],
															[0, 0, 0, 0, 0, 1, 0, 1],
															[1, 1, 1, 1, 0, 0, 1, 1],
															[1, 0, 0, 0, 1, 1, 1, 1]];
													
		public static const thingReachabilityMap : Array = [[1, 1, 0, 0, 0, 0, 1, 1],
														  [1, 1, 0, 0, 0, 0, 1, 1],
														  [0, 0, 1, 1, 0, 1, 1, 1],
														  [0, 0, 1, 1, 1, 0, 1, 1],
														  [0, 0, 0, 1, 1, 1, 0, 1],
														  [0, 0, 1, 0, 1, 1, 0, 1],
														  [1, 1, 1, 1, 0, 0, 1, 1],
														  [1, 1, 1, 1, 1, 1, 1, 1]];
		
		//out of 6
		public static var leftBehindProbability:Number = 2
		public static var humanKillingProbability:Number = 2;
		public static var humanInfectedRefusalProbability = 2;
		
		public static var thingKillingProbability:Number = 3;
		public static var thingOpenAssimilationProbability:Number = 2;
		
		public static var thingCautiousnessLevel:Number = 1;
		
		public static var rooms:Array;
		
		public static var draggableCharacter:Player;
		public static var isLightOn:Boolean = true;
		
		public static var plantedCharges:Array = [];
		
			
	}
	
}
