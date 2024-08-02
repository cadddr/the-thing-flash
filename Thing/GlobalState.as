package  {
	import flash.display.MovieClip;
	import characters.*;

	public class GlobalState {

		public static var DEBUG:Boolean = false;

		public static var draggableCharacter:Player;
		public static var isLightOn:Boolean = true;
 		public static var plantedCharges:Array = [];

		public static const DARK_PURPLE: uint = 0x1b1b2f;
		public static const BRIGHT_RED: uint = 0xe43f5a;
		public static const DARK_BLUE: uint = 0x162447;
		public static const LIGHTER_BLUE: uint = 0x1f4068;

		public static const DARK_GREY: uint = 0x222831;
		public static const LIGHTER_GREY: uint = 0x30475e;
		public static const BRIGHT_ORANGE: uint = 0xf2a365;
		public static const OFF_WHITE: uint = 0xececec;

		public static const CHARACTER_PLACED_IN_ROOM = "characterPlacedInRoom";
		public static const LIGHT_SWITCHED = "lightSwitched";
		
		private static var globalEventHandlers: Object = {
			characterPlacedInRoom: new Array(), 
			lightSwitched: new Array()
		};

		public static function addGlobalEventListener(type: String, handler: Function) {
			globalEventHandlers[type].push(handler);
		}

		public static function removeGlobalEventListener(type: String, handler: Function) {
			if (globalEventHandlers[type].indexOf(handler) != -1) {
				globalEventHandlers[type].remove(handler);
			}
		}

		public static function globalDispatchEvent(e:*) {
			for each (var func in globalEventHandlers[e.type]) {
				trace('dispatching', func)
				func(e);
			}
		}
	}
}
