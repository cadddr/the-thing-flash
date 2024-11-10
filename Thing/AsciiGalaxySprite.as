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
			asciiGalaxy = new AsciiGalaxy(180, 60);
			bufferGalaxy = new AsciiGalaxy(180, 60);

			addEventListener(Event.ADDED_TO_STAGE, function (e: * ) {
				var format: TextFormat = new TextFormat("Courier New", 12, 0xFFFFFF);
				textField.defaultTextFormat = format;
				textField.width = 1280;
				textField.height = 900; 

				addChild(textField);
				rerender();
			});

		}

		public function get VScroll() {
			return vScroll;
		}

		public function set VScroll(value) {
			vScroll = value;

			if (vScroll > asciiGalaxy.height) {
				asciiGalaxy, bufferGalaxy = bufferGalaxy, asciiGalaxy
				vScroll = 0;
				//asciiGalaxy.init();
			}

			if (vScroll < 0) {
				asciiGalaxy, bufferGalaxy = bufferGalaxy, asciiGalaxy
				vScroll = bufferGalaxy.height;
				//bufferGalaxy.init();
			}

			rerender();
		}

		public function rerender() {
			innerHTML = "";

			for (var r = 0; r < vScroll; r++) {
				if (!r == 0) innerHTML += "\n";
				innerHTML += bufferGalaxy.fieldRows[bufferGalaxy.height - vScroll + r];
			}

			for (var r = 0; r < asciiGalaxy.height - vScroll; r++) {
				if (!r == 0) innerHTML += "\n";
				innerHTML += asciiGalaxy.fieldRows[r];
			}
		}

	}
}