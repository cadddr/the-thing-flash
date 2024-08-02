package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import rooms.*;
	import items.GeneratorSwitch;
	import asciiRooms.AsciiRoomBase;
	import Utils;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	
	
	public class AsciiGeneratorSwitch extends GeneratorSwitch {
		// spawned in room via spawnInteractable
		
		protected function getSelection(): MovieClip {
			return asciiSelection;
		}	

		override protected function highlightForInteraction(): void {
			getSelection().gotoAndPlay(1);
			getSelection().visible = true;
		}

		override protected function unhighlightForInteraction(): void {
			getSelection().visible = false;
			getSelection().gotoAndStop(1);
		}

		override protected function interactOnMouseOver(e:MouseEvent): void
		{
			if(GlobalState.draggableCharacter 
			   && GlobalState.draggableCharacter.currentRoom.interactables.indexOf(this) != -1)
				{
					highlightForInteraction();
				}
		}
		
		override protected function interactOnMouseOut(e:MouseEvent): void
		{
			unhighlightForInteraction();
		}
		
		override protected function interactOnMouseClick(e:MouseEvent): void
		{
			if(GlobalState.draggableCharacter)
				if(GlobalState.draggableCharacter.currentRoom.interactables.indexOf(this) != -1)
				{
					switchPower();
					GlobalState.draggableCharacter.finalizeAction();
				}
		}

		override public function switchPower()
		{		
			super.switchPower();
			// stage.color = Utils.scaleColor(
			// 	GlobalState.DARK_PURPLE, 
			// 	1.0 * int(GlobalState.isLightOn) +
			// 	0.75 * (1 - int(GlobalState.isLightOn))
			// )
			var start = 1.0 * int(!GlobalState.isLightOn) +
				0.75 * (1 - int(!GlobalState.isLightOn))
			var value = 1.0 * int(GlobalState.isLightOn) +
				0.75 * (1 - int(GlobalState.isLightOn));
			Utils.tweenValue(stage, "rotation", None.easeNone, start, value, 0.5, function(e:TweenEvent) {
				stage.color = Utils.scaleColor(GlobalState.DARK_PURPLE, e.position);
			});
			
			this.gotoAndStop(GlobalState.isLightOn ? 1 : 2);
			unhighlightForInteraction();
		}
	}
}
