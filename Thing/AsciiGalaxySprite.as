package {
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import AsciiGalaxy;
	import flash.events.Event;

	public class AsciiGalaxySprite extends Sprite {

		var textField: TextField;
		function get innerHTML() {
			return textField.text;
		}

		function set innerHTML(value) {
			textField.text = value;
		}

		var asciiGalaxy: AsciiGalaxy;
		var bufferGalaxy: AsciiGalaxy;
		var vScroll = 0;

		public function AsciiGalaxySprite() {
			textField = new TextField();
			asciiGalaxy = new AsciiGalaxy(180 * 2, 60 * 2);
			bufferGalaxy = new AsciiGalaxy(180 * 2, 60 * 2);

			addEventListener(Event.ADDED_TO_STAGE, function (e: * ) {
				var format: TextFormat = new TextFormat("Courier New", 8, 0xFFFFFF);
				textField.defaultTextFormat = format;
				textField.width = 1280;
				textField.height = 900; 
				textField.mouseEnabled = false;

				addChild(textField);
				rerender();
			});

		}

		public function get VScroll() {
			return vScroll;
		}

		var yOffset = 0;
		public function set VScroll(value) {
			if (Math.abs(yOffset) < 8) {
				yOffset += (value >= vScroll ? 1 : -1);
				textField.y = yOffset;
				rerender(); // to take up same time
				return;
			}
			else {
				yOffset = 0;
				textField.y = 0;
			}
			
			vScroll = value;
			if (vScroll >=asciiGalaxy.height) { // we scrolled all of current galaxy
				var temp:AsciiGalaxy = asciiGalaxy;
				asciiGalaxy = bufferGalaxy;
				bufferGalaxy = temp; // make buffer current galaxy with zero scroll
				vScroll = 0;
				//asciiGalaxy.init();
			}

			else if (vScroll < 0) { // we scrolled buffer galaxy away from screen
				var temp:AsciiGalaxy = asciiGalaxy;
				asciiGalaxy = bufferGalaxy;
				bufferGalaxy = temp;
				vScroll = bufferGalaxy.height;
				//bufferGalaxy.init();
			}

			rerender();
		}

		public function rerender() {
			innerHTML = "";
			// vScroll is how many of top rows render from (bottom of) buffer galaxy
			for (var r = 0; r < vScroll; r++) {
				// if (!r == 0) 

				
				innerHTML += bufferGalaxy.fieldRows[bufferGalaxy.height - vScroll + r];
				innerHTML += "\n";
			}
			// remaining rows are from current galaxy
			for (var r = 0; r < asciiGalaxy.height - vScroll; r++) {
				// if (!r == 0) 
				
				innerHTML += asciiGalaxy.fieldRows[r];
				innerHTML += "\n";
			}
		}

	}
}