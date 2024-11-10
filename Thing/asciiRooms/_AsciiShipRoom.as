package asciiRooms {
	
	import flash.display.MovieClip;
	import flash.ui.Keyboard
	import flash.events.*;
	
	
	public class AsciiShipRoom extends MovieClip {
		var speedX = 0;
		var speedY = -1;
		
		public function AsciiShipRoom() {
			
			var caller = this
			addEventListener(Event.ADDED_TO_STAGE, function(e: Event): void {
				stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e: KeyboardEvent): void {
					switch (e.keyCode) {
						case Keyboard.A:
							caller.speedX -= 1;
							caller.rotation += 5;
							break;
						case Keyboard.D:
							caller.speedX += 1;
							caller.rotation -= 5;
							break;
						case Keyboard.W:
							caller.speedY -= 1;
							break;
						case Keyboard.S:
							caller.speedY += 1;
							break;
					}
				});
				caller.addEventListener(Event.ENTER_FRAME, function(e:*): void {
					caller.x += caller.speedX;
					caller.y += caller.speedY;
				});
			})
		}
	}
	
}
