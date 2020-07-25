package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import ui.LevelSelectionScreen;
	
	public class GameOverScreen extends MovieClip {
		
		public function GameOverScreen() {
			var caller = this;
			goBackButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelSelectionScreen(null));
						stage.removeChild(caller);
			});
		}
	}
	
}
