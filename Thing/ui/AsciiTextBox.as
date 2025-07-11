package  ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import Utils;
	import fl.transitions.easing.*;
	
	
	public class AsciiTextBox extends MovieClip {
		
		var rows:Number = 5;
		var cols:Number = 5;
		var textToDisplay: String;
		public function AsciiTextBox() {
			var caller = this;

			this.addEventListener(Event.ADDED_TO_STAGE, function(e: Event): void {
				var textToDisplay = "Holy, Shit. The Matrix has you!";
				Utils.tweenValue({"x":0}, "x", None.easeNone, 0, textToDisplay.length, 1.0, function(e:*) {
					caller.drawText(textToDisplay.substring(0, e.position));
				});
			});
		}

		function drawText(textToDisplay) {
			textbox.border = '1';
			textbox.text = "";
			cols = textToDisplay.length + 2 + 2;
			textbox.height = rows * 40.25;
			textbox.width = cols * 25.;
		
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
