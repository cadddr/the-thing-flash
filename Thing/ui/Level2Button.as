package ui {
	
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import levels.Level2;
	
	
	public class Level2Button extends SimpleButton {
		
		
		public function Level2Button() {
			this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new Level2());
			});
		}
	}
	
}
