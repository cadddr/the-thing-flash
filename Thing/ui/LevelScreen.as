package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.LevelBase;
	import ui.LevelSelectionScreen;
	import ui.GameOverScreen;
	import fl.VirtualCamera;
	import characters.Thing;
	import flash.display.SimpleButton;
	import flash.events.KeyboardEvent;
	
	public class LevelScreen extends MovieClip {
		
		public function LevelScreen(level: LevelBase, camera: VirtualCamera=null, cameraLayer: MovieClip=null, cameraLayer2: MovieClip=null) {
			var caller: LevelScreen = this;
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event): void {
			
				goBackButton.addEventListener(MouseEvent.CLICK, function(e:MouseEvent): void {
						stage.addChild(new LevelSelectionScreen(null));
						stage.removeChild(level);
						stage.removeChild(caller);
				});
				
				level.btn_endTurn = endTurnButton;
				level.onGameOver = function(): void {
					stage.addChild(new GameOverScreen());
					stage.removeChild(level);
					stage.removeChild(caller);
				}

				level.setCameraAndLayer(camera, cameraLayer);
				cameraLayer.addChild(level);
				level.reallocateRoomTilesToLayers(cameraLayer, cameraLayer2);

				stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e:KeyboardEvent): void {
					if (new Array([37, 38, 39, 40, 187, 189]).indexOf(e.keyCode) != 0) {
						camera.unpinCamera();
					}

					var cameraPanAmount: Number = 10;
					

					camera.moveBy(e.keyCode == 37 ? cameraPanAmount : 0, 0);
					camera.moveBy(e.keyCode == 39 ? -cameraPanAmount : 0, 0);
					camera.moveBy(0, e.keyCode == 38 ? cameraPanAmount : 0);
					camera.moveBy(0, e.keyCode == 40 ? -cameraPanAmount : 0);

					camera.zoomBy(e.keyCode == 187 ? 110 : 100);
					camera.zoomBy(e.keyCode == 189 ? 90 : 100);

								
					trace("camera position", camera.getPosition().x, camera.getPosition().y);
				});	
			});

			
		}
	}
	
}
