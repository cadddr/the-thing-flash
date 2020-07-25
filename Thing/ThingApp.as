package  {

	import flash.display.MovieClip;
	import ui.LevelSelectionScreen;
	import flash.events.Event;
	import fl.VirtualCamera;
	import asciiRooms.AsciiWallTile;

	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class ThingApp extends MovieClip
	{

		
		public function ThingApp() {

			for(var i:int = 0; i < numChildren; i++) {
				trace("child", getChildAt(i), getChildAt(i).name);
			}
			var wallTile = new AsciiWallTile()
			// MovieClip(getChildByName("Layer_1")).addChild(wallTile);

			for(var i:int = 0; i < MovieClip(getChildByName("Layer_1")).numChildren; i++) {
				trace("child", MovieClip(getChildByName("Layer_1")).getChildAt(i), MovieClip(getChildByName("Layer_1")).getChildAt(i).name);
			}
			

				var camera = VirtualCamera.getCamera(root);
				trace("getChildByName", MovieClip(getChildByName("Layer_1")).getChildByName("testText"));
				camera.pinCameraToObject(MovieClip(getChildByName("Layer_1")).getChildByName("testText"));
				// camera.unpinCamera();
				trace('camera', camera);
				camera.setPosition(500,500);
				camera.zoomBy(50);
				camera.setTint(0x00FF00, 100);	
			stage.addChild(new LevelSelectionScreen(camera));

			// addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {

			// });
		}
	}

}
