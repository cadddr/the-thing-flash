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
	// import shaders.GlitchEffect;
	import AsciiGalaxySprite;
	
	public class LevelScreen extends MovieClip {
		var asciiGalaxy: AsciiGalaxySprite;
		
		private static const KEY_LEFT: int = 37; // Left arrow key
		private static const KEY_UP: int = 38; // Up arrow key
		private static const KEY_RIGHT: int = 39; // Right arrow key
		private static const KEY_DOWN: int = 40; // Down arrow key
		private static const KEY_ZOOM_IN: int = 187; // Plus key (Zoom in)
		private static const KEY_ZOOM_OUT: int = 189; // Minus key (Zoom out)

		private static const KEY_SPACE: int = 32;
		private static const KEY_D: int = 68;
		private static const KEY_TAB: int = 9;

		private static const CAMERA_PAN_AMOUNT: Number = 10; // Amount to pan the camera
		private static const CAMERA_ZOOM_IN_AMOUNT: Number = 110; // Amount to zoom in the camera
		private static const CAMERA_ZOOM_OUT_AMOUNT: Number = 90; // Amount to zoom out the camera


		public function LevelScreen(level: LevelBase, camera: VirtualCamera = null, cameraLayer: MovieClip = null) {
			// var shader = new GlitchEffect();
			var caller = this;

			this.addEventListener(Event.ADDED_TO_STAGE, function(e: Event): void {
				// this fixes floor tile mouse glitching
				caller.removeChild(backgroundSprite);
				caller.parent.addChildAt(backgroundSprite, 0);


				asciiGalaxy = new AsciiGalaxySprite();
				// var galaxyLayer = MovieClip(cameraLayer.parent.getChildByName("galaxy"));
				// asciiGalaxy.x = -2200
				// asciiGalaxy.y = -1500
				// galaxyLayer.
				addChild(asciiGalaxy);

				level.setCameraAndLayer(camera, cameraLayer);

				cameraLayer.addChild(level); // level needs to be on camera layer for scrolling and zooming

				goBackButton.addEventListener(MouseEvent.CLICK, function(e: MouseEvent): void {
					stage.addChild(new LevelSelectionScreen(null));
					stage.removeChild(level); // TODO:
					stage.removeChild(caller);
				});
				goBackButton.tabEnabled = false;

				endTurnButton.addEventListener(MouseEvent.CLICK, function (e: MouseEvent): void {
					level.endTurn();
				});
				endTurnButton.tabEnabled = false;

				level.onGameOver = function(): void {
					stage.addChild(new GameOverScreen());
					stage.removeChild(level);
					stage.removeChild(caller);
				};

				
				// shader.x = cameraLayer.x
				// shader.y = cameraLayer.y

				// stage.addEventListener(Event.ENTER_FRAME, function (e:*) {
				// 	stage.addChild(shader);
				// 	shader.initSource(stage.root);
				// })
				

				stage.addEventListener(KeyboardEvent.KEY_DOWN, function(e: KeyboardEvent): void {
					if ([KEY_LEFT, KEY_UP, KEY_RIGHT, KEY_DOWN, KEY_ZOOM_IN, KEY_ZOOM_OUT].indexOf(e.keyCode) != -1) {
						camera.unpinCamera();
						handleCameraControls(camera, e);
						return;
					}

					handleLevelControls(level, e);
				});				
			});
		}

		private function handleCameraControls(camera: VirtualCamera, e: KeyboardEvent): void {
			switch (e.keyCode) {
				case KEY_LEFT: // Left arrow key
					camera.moveBy(CAMERA_PAN_AMOUNT, 0);
					break;
				case KEY_RIGHT: // Right arrow key
					camera.moveBy(-CAMERA_PAN_AMOUNT, 0);
					break;
				case KEY_UP: // Up arrow key
					camera.moveBy(0, CAMERA_PAN_AMOUNT);
					asciiGalaxy.VScroll += 1;
					break;
				case KEY_DOWN: // Down arrow key
					camera.moveBy(0, -CAMERA_PAN_AMOUNT);
					asciiGalaxy.VScroll -= 1;
					break;
				case KEY_ZOOM_IN: // Plus key (Zoom in)
					camera.zoomBy(CAMERA_ZOOM_IN_AMOUNT);
					break;
				case KEY_ZOOM_OUT: // Minus key (Zoom out)
					camera.zoomBy(CAMERA_ZOOM_OUT_AMOUNT);
					break;
			}
		}

		private function handleLevelControls(level: LevelBase, e: KeyboardEvent): void {
			switch (e.keyCode) {
				case KEY_D:
					toggleDebugMode(level);
					break;
				case KEY_SPACE:
					level.endTurn();
					break;
				case KEY_TAB:
					trace ('tab')
					level.selectActiveCharacter();
					break;
			}
		}

		private function toggleDebugMode(level: LevelBase): void {
			trace("Debug mode", GlobalState.DEBUG);
			GlobalState.DEBUG = !GlobalState.DEBUG;
			level.refreshThingsVisibility();
		}
	}
}