package asciiRooms
{
    import flash.display.MovieClip;
    import characters.Interactable;
    import flash.events.*;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import flash.events.Event;
    import rooms.Room;

    public class AsciiTile extends Interactable {
        private var colorTransform: ColorTransform = new ColorTransform();

        public function AsciiTile()
        {
            addEventListener(Event.ADDED_TO_STAGE, function(e:Event): void {
                unhighlightForInteraction();
            });

            addEventListener(Event.ENTER_FRAME, function(e:Event): void {
                if (GlobalState.draggableCharacter != null) {
                    var dist = getDistanceFrom(GlobalState.draggableCharacter.x, GlobalState.draggableCharacter.y);
                    
                    if (dist > 400) {
                        alpha=0;
                    } 
                    else {
                        alpha = 1 -  dist / 800;
                    }
                }
            });
        }

        protected function getSelection(): MovieClip {
			return null;
		}

        override protected function interactOnMouseOver(e:MouseEvent): void {
            highlightForInteraction();
        }
		override protected function interactOnMouseOut(e:MouseEvent): void {
            unhighlightForInteraction();
        }

        override protected function highlightForInteraction(): void {
            if (getSelection() != null)
            {getSelection().visible = true;}
        }
        override protected function unhighlightForInteraction(): void {
            if (getSelection() != null)
            {getSelection().visible = false;}
        }

        private function getDistanceFrom(sourceX, sourceY) {
            var global = localToGlobal(new Point(this.x, this.y));
            var x = parent.x + this.x - sourceX;
            var y = parent.y + this.y - sourceY;
            var dist = Math.sqrt(x*x + y*y);
            return dist;
        }


        public function applyLighting(sourceX, sourceY) {            
            var kd = 1;//0.0025
            var dist = getDistanceFrom(sourceX, sourceY);
            var diffuse = Math.cos(Math.atan(dist + 5));

            this.transform.colorTransform = new ColorTransform(0,0,0,1,27+(255-27)*diffuse,27+(255-27)*diffuse,47+(255-47)*diffuse,1);
		}

        public function unapplyLighting() {
            // this.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 31, 64, 104, 1);
        }
    }
}