package ui {
	
	import flash.display.SimpleButton;
	import levels.Level1;
	import flash.events.MouseEvent;
	
	public class Level1Button extends SimpleButton {
		
		
		public function Level1Button() {
			this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent) {
					stage.addChild(new Level1());
			});
			
		}
	}
	
}
