package items {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import rooms.*;
	import items.GeneratorSwitch;
	import asciiRooms.AsciiRoomBase;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	
	
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
			if (!GlobalState.isLightOn) {
				var albedoRgba = new Color();
				albedoRgba.tintColor = stage.color;
				albedoRgba.tintMultiplier = 0.75 * (1 - int(GlobalState.isLightOn));

				stage.color = new ColorTransform(0,0,0,1,
					albedoRgba.redOffset,
					albedoRgba.greenOffset,
					albedoRgba.blueOffset
				).color;
			}
			else {
				stage.color = GlobalState.DARK_PURPLE;
			}
			
			this.gotoAndStop(GlobalState.isLightOn ? 1 : 2);
			unhighlightForInteraction();
		}
	}
}
