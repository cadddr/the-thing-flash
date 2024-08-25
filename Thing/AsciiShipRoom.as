package asciiRooms {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard
	
	
	public class AsciiShipRoom extends MovieClip {
		
		
		public function AsciiShipRoom() {
			
			var caller = this
			addEventListener(Event.ADDED_TO_STAGE, function(e: Event): void {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e: KeyboardEvent): void {
					trace('keyboard', e.keyCode)
					switch (e.keyCode) {
						case Keyboard.A {
							caller.x -= 10;
						}
						case Keyboard.D {
							caller.x += 10;
						}
						case Keyboard.W {
							caller.y -= 10;
						}
						case Keyboard.S {
							caller.y += 10;
						}
					}
				})
			})
		}
	}
	
}
