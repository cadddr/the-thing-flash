package  {

	import flash.display.MovieClip;
	import ui.LevelSelectionScreen;
	import flash.events.Event;
	import fl.VirtualCamera;
	import asciiRooms.AsciiWallTile;

	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class ThingApp extends MovieClip {
		var camera: VirtualCamera;
		var cameraLayer: MovieClip;
	
		public function ThingApp() {
			camera = VirtualCamera.getCamera(root)
			cameraLayer = MovieClip(getChildByName("Layer_1"));

			stage.addChild(new LevelSelectionScreen(camera, cameraLayer));
		}
	}

}
