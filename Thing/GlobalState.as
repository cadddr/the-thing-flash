package  {
	import flash.display.MovieClip;
	import characters.*;
	public class GlobalState {

		public static var DEBUG:Boolean = false;

		public static const thingKillingProbability:Number = 3;
		public static const thingOpenAssimilationProbability:Number = 2;
		public static const humanKillingProbability:Number = 2;
		public static var thingCautiousnessLevel:Number = 1;

		public static var rooms:Array;

		public static var draggableCharacter:Player;
		
		public static var isLightOn:Boolean = true;

 		public static var plantedCharges:Array = [];

 		public static var thingType = Thing;

		public static const DARK_PURPLE: uint = 0x1b1b2f;
		public static const BRIGHT_RED: uint = 0xe43f5a;
		public static const DARK_BLUE: uint = 0x162447;
		public static const LIGHTER_BLUE: uint = 0x1f4068;

		public static const DARK_GREY: uint = 0x222831;
		public static const LIGHTER_GREY: uint = 0x30475e;
		public static const BRIGHT_ORANGE: uint = 0xf2a365;
		public static const OFF_WHITE: uint = 0xececec;


		public static const ROOM_BECAME_REACHABLE = "roomBecameReachable";
		public static const ROOM_BECAME_UNREACHABLE = "roomBecameUnreachable";

		public static const CHARACTER_PLACED_IN_ROOM = "characterPlacedInRoom";


	}

}
