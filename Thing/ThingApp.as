package  {

	import flash.display.MovieClip;
	import ui.LevelSelectionScreen;
	import flash.events.Event;

	//todo: hovering players can be underneath other objects
	//todo: players can plant bombs to the rooms there are not in
	public class ThingApp extends MovieClip
	{
		public function ThingApp() {			
			stage.addChild(new LevelSelectionScreen());
		}
	}

}
