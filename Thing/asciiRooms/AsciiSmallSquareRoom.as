package asciiRooms {
	
	import flash.display.MovieClip;
	import rooms.Room;
	import characters.*;
	import flash.events.*;
	import items.AsciiGeneratorSwitch;
	import flash.geom.ColorTransform;
	import GlobalState;
	import asciiRooms.AsciiTile;
	import flash.events.MouseEvent;
	
	
	public class AsciiSmallSquareRoom extends AsciiRoomBase {
		override protected function getFloor(): MovieClip {
            return asciiFloor;
    	}
	}
}
