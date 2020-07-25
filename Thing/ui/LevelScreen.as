package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import ui.LevelSelectionScreen;
	import ui.GameOverScreen;
	import fl.VirtualCamera;
	import characters.Thing;
	import flash.display.SimpleButton;
	
	public class LevelScreen extends MovieClip {

		var camera: VirtualCamera;
		
		public function LevelScreen(level:LevelBase, camera:VirtualCamera) {
			// this.camera = camera;
			this.camera = VirtualCamera.getCamera(root);
			trace("my camera", this.camera)
			var caller = this;
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
			
				goBackButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						// stage.addChild(new LevelSelectionScreen(null));
						// stage.removeChild(level);
						// stage.removeChild(caller);
						camera.unpinCamera();
						camera.moveBy(100,100);
				});
				
				level.btn_endTurn = endTurnButton;
				level.onGameOver = function() {
					stage.addChild(new GameOverScreen());
					stage.removeChild(level);
					stage.removeChild(caller);
				}
				
				stage.addChild(level);

				trace('camera', camera);
				camera.setPosition(100,200);
				camera.zoomBy(100);
				camera.setTint(0xFF0000, 100);	
			});
		}
	}
	
}
