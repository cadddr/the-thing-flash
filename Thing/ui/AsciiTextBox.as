package  ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import Utils;
	import fl.transitions.easing.*;
	
	
	public class AsciiTextBox extends MovieClip {
		
		var rows:Number = 5;
		var cols:Number = 5;
	
		public function AsciiTextBox() {
			var caller = this;

			this.addEventListener(Event.ADDED_TO_STAGE, function(e: Event): void {
				// var textToDisplay = "Holy, Shit. The Matrix has you!";
				// caller.animateDrawText(textToDisplay);
			});
		}

		public function animateDrawText(textToDisplay:String) {
			Utils.tweenValue({"x":0}, "x", None.easeNone, 0, textToDisplay.length, textToDisplay.length / 30, function(e:*) {
				drawText(textToDisplay.substring(0, e.position));
			});
		}

		function drawText(textToDisplay:String) {
			textbox.border = '1';
			textbox.text = "";
			cols = textToDisplay.length + 2 + 2;
			textbox.height = rows * 40.25;
			textbox.width = cols * 25.;
			textbox.x = stage.stageWidth / 2 - textbox.width / 2;
		
			for (var i = 0; i < rows; i++) {
				for (var j = 0; j < cols; j++) {
					var cur_char = " ";
					if ((i == 0) || (i == rows - 1)) {
						cur_char = "—";
						if ((j == 0) || (j == cols - 1)) {
							cur_char = "+";
						}
					}
					else if ((j == 0) || (j == cols - 1)) {
						cur_char = "|";
					}
					else if (i == int(rows / 2) && j > 1 && j < cols - 2){
						cur_char = textToDisplay.charAt(j-2);
					}
					if (j == cols - 1) {
						cur_char += "\n";
					}
					textbox.text += cur_char;	
				}	
			}
		}
	}
}
