package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.Level1;
	import levels.Level2;
	import levels.Level3;
	import levels.Level4;
	import levels.Level8;
	import ui.LevelScreen;
	
	public class LevelSelectionScreen extends MovieClip {
		
		
		public function LevelSelectionScreen() {
			var caller = this;
			
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				stage.color = 0x1b1b2f;
				
				levelSelectionButton1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new Level1()));
						stage.removeChild(caller);
				});
				
				levelSelectionButton2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new Level2()));
						stage.removeChild(caller);
				});
				
				levelSelectionButton3.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new Level3()));
						stage.removeChild(caller);
				});
				
				levelSelectionButton4.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new Level4()));
						stage.removeChild(caller);
				});
				
				levelSelectionButton8.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new Level8()));
						stage.removeChild(caller);
				});
			});
		}
	}
	
}
