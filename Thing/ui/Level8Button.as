package ui {

	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class Level8Button extends SimpleButton {

		public function Level8Button() {
			this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new Level8());
			});
		}
	}

}
