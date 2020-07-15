package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import ui.LevelSelectionScreen;
	import ui.GameOverScreen;
	
	public class LevelScreen extends MovieClip {
		
		public function LevelScreen(level:LevelBase) {
			var caller = this;
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				
				testLabel.text = level.toString();
				//testLabel.htmlText = "<p style=\"color:red;\">This is a paragraph.</p>";
			
				goBackButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelSelectionScreen());
						stage.removeChild(level);
						stage.removeChild(caller);
				});
				
				level.btn_endTurn = endTurnButton;
				level.onGameOver = function() {
					stage.addChild(new GameOverScreen());
					stage.removeChild(level);
					stage.removeChild(caller);
				}
				
				stage.addChild(level);
			});
		}
	}
	
}
