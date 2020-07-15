package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import ui.LevelSelectionScreen;
	
	public class LevelScreen extends MovieClip {
		
		public function LevelScreen(level:LevelBase) {
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				
				testLabel.text = level.toString();
				//testLabel.htmlText = "<p style=\"color:red;\">This is a paragraph.</p>";
			
				goBackButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelSelectionScreen());
				});
				
				level.btn_endTurn = endTurnButton;
				
				stage.addChild(level);
			});
		}
	}
	
}
