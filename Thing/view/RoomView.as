package view
{
    import flash.display.MovieClip;

    public class RoomView extends InteractableView {
        private var tileWidth:Number = 25;
		private var tileHeight:Number = 40.25;

        public function computePositionInRoom(whomX: Number, whomY: Number, whomW: Number, whomH: Number): Array {
			
			if (whomX < tileWidth) {
				whomX = tileWidth
			}

			if (whomY < tileHeight) {
				whomY = tileHeight
			}
			
			return [this.x + whomX - whomX % tileWidth, this.y + whomY - whomY % tileHeight];
        }
    }
}