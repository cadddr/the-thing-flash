package ui {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import levels.*;
	import ui.LevelScreen;
	
	public class LevelSelectionScreen extends MovieClip {
		
		
		public function LevelSelectionScreen() {
			levelSelectionButton1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new LevelScreen(new Level1()));
			});
			
			levelSelectionButton2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new LevelScreen(new Level2()));
			});
			
			levelSelectionButton3.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new LevelScreen(new Level3()));
			});
			
			levelSelectionButton8.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new LevelScreen(new Level8()));
			});
		}
	}
	
}
