package  {
	import flash.display.MovieClip;
	import characters.Player;
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


	}

}
