package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.*;
	import fl.VirtualCamera;
	
	public class LevelSelectionScreen extends MovieClip {
		
		
		public function LevelSelectionScreen(camera:VirtualCamera=null, cameraLayer: MovieClip=null, cameraLayer2: MovieClip = null) {
			var caller = this;
			trace(cameraLayer);
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				stage.color = 0x1b1b2f;
				
				
				asciiLevelSelectionButton1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new AsciiLevel1()));
						stage.removeChild(caller);
				});

				asciiLevelSelectionButton2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						stage.addChild(new LevelScreen(new AsciiLevel2(), camera, cameraLayer, cameraLayer2));
						stage.removeChild(caller);
				});

			});
		}
	}
	
}
