package  {

	import flash.display.MovieClip;
	import ui.LevelSelectionScreen;
	import fl.VirtualCamera;
	import flash.utils.describeType;
	import flash.ui.Mouse;
	import flash.events.*;


	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class ThingApp extends MovieClip {
		var camera: VirtualCamera;
		var cameraLayer: MovieClip;
	
		public function ThingApp() {
			camera = VirtualCamera.getCamera(root)
			cameraLayer = MovieClip(getChildByName("Layer_1"));

			trace(cameraLayer);
			trace(cameraLayer.parent)
			trace(cameraLayer.parent == stage)
			trace(cameraLayer.parent == stage.root)
			trace(cameraLayer.parent == root)
			trace(cameraLayer.parent == this)

			// using this rather than stage as parent for child clips
			addChild(new LevelSelectionScreen(camera, cameraLayer));			
		}
	}
}
