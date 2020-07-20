package asciiRooms
{
    import flash.display.MovieClip;
    import characters.Interactable;
    import flash.events.*;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;

    class AsciiTile extends Interactable {

        public function AsciiTile()
        {
            addEventListener(Event.ADDED_TO_STAGE, function(e:Event) {
                unhighlightForInteraction();
                
            });
        }

        protected function getSelection(): MovieClip {
            trace ("shouldn't get here");
			return null;
		}

        override protected function interactOnMouseOver(e:MouseEvent): void {
            highlightForInteraction();
        }
		override protected function interactOnMouseOut(e:MouseEvent): void {
            unhighlightForInteraction();
        }

        override protected function highlightForInteraction(): void {
            getSelection().visible = true;
        }
        override protected function unhighlightForInteraction(): void {
            getSelection().visible = false;
        }

    }
}