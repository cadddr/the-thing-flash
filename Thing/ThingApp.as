package  {

	import flash.display.MovieClip;
	import ui.LevelSelectionScreen;
	import fl.VirtualCamera;


	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class ThingApp extends MovieClip {
		var camera: VirtualCamera;
		var cameraLayer: MovieClip;
		var cameraLayer2: MovieClip;
	
		public function ThingApp() {
			camera = VirtualCamera.getCamera(root)
			cameraLayer = MovieClip(getChildByName("Layer_1"));
			cameraLayer2 = MovieClip(getChildByName("Layer_2"));
			trace(cameraLayer);
			trace(cameraLayer.parent)
			trace(cameraLayer.parent == stage)
			trace(cameraLayer.parent == stage.root)
			trace(cameraLayer.parent == root)
			trace(cameraLayer.parent == this)

			// stage.
			addChild(new LevelSelectionScreen(camera, cameraLayer, cameraLayer2));
		}
	}
}
