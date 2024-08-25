package ui {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import levels.*;
	import fl.VirtualCamera;
	import shaders.GlitchEffect;
	
	public class LevelSelectionScreen extends MovieClip {
		
		
		public function LevelSelectionScreen(camera:VirtualCamera=null, cameraLayer: MovieClip=null) {
			var shader = new GlitchEffect();
			var caller = this; // this becomes global when event listeners are called
			
			this.addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
				stage.color = 0x1b1b2f; // TODO: why is this set here?
					
				asciiLevelSelectionButton1.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						caller.parent.addChild(new LevelScreen(new AsciiLevel1(), camera, cameraLayer));
						caller.parent.removeChild(caller);
				});

				asciiLevelSelectionButton2.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						// parent is top level clip
						caller.parent.addChild(new LevelScreen(new AsciiLevel2(), camera, cameraLayer));
						caller.parent.removeChild(caller);
				});

				asciiLevelSelectionButton3.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
						// parent is top level clip
						caller.parent.addChild(new LevelScreen(new AsciiLevel3(), camera, cameraLayer));
						caller.parent.removeChild(caller);
				});

				title.parent.addChild(shader);
				shader.x = title.x
				shader.y = title.y
				shader.initSource(title);
			});
		}
	}
}
