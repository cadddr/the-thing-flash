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
		
		private static const KEY_LEFT: int = 37;
		private static const KEY_UP: int = 38;
		private static const KEY_RIGHT: int = 39;
		private static const KEY_DOWN: int = 40;
		private static const KEY_ZOOM_IN: int = 187;
		private static const KEY_ZOOM_OUT: int = 189;
		private static const CAMERA_PAN_AMOUNT: Number = 10;
		private static const CAMERA_ZOOM_IN_AMOUNT: Number = 110;
		private static const CAMERA_ZOOM_OUT_AMOUNT: Number = 90;

		public function LevelScreen(level: LevelBase, camera: VirtualCamera = null, cameraLayer: MovieClip = null, cameraLayer2: MovieClip = null) {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(e: Event): void {
			goBackButton.addEventListener(MouseEvent.CLICK, onGoBackButtonClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);

			level.btn_endTurn = endTurnButton;
			level.onGameOver = onGameOver;

			level.setCameraAndLayer(camera, cameraLayer);
			cameraLayer.addChild(level);
			level.reallocateRoomTilesToLayers(cameraLayer, cameraLayer2);
		}

		private function onGoBackButtonClick(e: MouseEvent): void {
			stage.addChild(new LevelSelectionScreen(null));
			stage.removeChild(level);
			stage.removeChild(this);
		}

		private function onGameOver(): void {
			stage.addChild(new GameOverScreen());
			stage.removeChild(level);
			stage.removeChild(this);
		}

		private function onKeyDown(e: KeyboardEvent): void {
			if ([KEY_LEFT, KEY_UP, KEY_RIGHT, KEY_DOWN, KEY_ZOOM_IN, KEY_ZOOM_OUT].indexOf(e.keyCode) != -1) {
				camera.unpinCamera();
			}

			switch (e.keyCode) {
				case KEY_LEFT:
					camera.moveBy(CAMERA_PAN_AMOUNT, 0);
					break;
				case KEY_RIGHT:
					camera.moveBy(-CAMERA_PAN_AMOUNT, 0);
					break;
				case KEY_UP:
					camera.moveBy(0, CAMERA_PAN_AMOUNT);
					break;
				case KEY_DOWN:
					camera.moveBy(0, -CAMERA_PAN_AMOUNT);
					break;
				case KEY_ZOOM_IN:
					camera.zoomBy(CAMERA_ZOOM_IN_AMOUNT);
					break;
				case KEY_ZOOM_OUT:
					camera.zoomBy(CAMERA_ZOOM_OUT_AMOUNT);
					break;
			}
		}
	}
}