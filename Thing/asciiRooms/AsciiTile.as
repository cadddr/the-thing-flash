package asciiRooms
{
    import flash.display.MovieClip;
    import characters.Interactable;
    import flash.events.*;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    import flash.geom.Point;

    class AsciiTile extends Interactable {
        var colorTransform: ColorTransform = new ColorTransform();

        public function AsciiTile()
        {
            // this.transform.colorTransform = new ColorTransform(0,0,0,1,27, 27, 47);
            // colorTransform.concat(this.transform.colorTransform);
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

        public function applyLighting(sourceX, sourceY) {
            var kd = 1;//0.0025
            var global = localToGlobal(new Point(this.x, this.y));
            var x = global.x - sourceX;
            var y = global.y - sourceY;
            var dist = Math.sqrt(x*x + y*y) / 25;
            var diffuse = Math.cos(Math.atan(dist));

            this.transform.colorTransform = new ColorTransform(0,0,0,1,255*diffuse,255*diffuse,255*diffuse,1);
            
            // this.transform.colorTransform = new ColorTransform(1,1,1,1,(255-27)*diffuse,(255-27)*diffuse,(255-47)*diffuse,1);
            // // this.transform.colorTransform = new ColorTransform(1,1,1,2*diffuse);
            // this.transform.colorTransform = new ColorTransform(diffuse,diffuse,diffuse,1,
            // colorTransform.redOffset, colorTransform.greenOffset, colorTransform.blueOffset);
		}

        public function unapplyLighting() {
            this.transform.colorTransform = new ColorTransform(0, 0, 0, 1, 31, 64, 104, 1);
        }
    }
}