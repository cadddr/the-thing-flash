package characters {
	import flash.display.MovieClip;
	import GlobalState;
	import characters.Interactable;
	import asciiRooms.AsciiRoomBase;
	import fl.VirtualCamera;
	import flash.geom.Point;
	import rooms.RoomBase;
	
	public class Character extends Interactable {
		
		public var policy: Function = null; //TODO: only needed for thing or assimilated?
		public var currentRoom: RoomBase = null;
		public var previousRoom: RoomBase = null;

		protected var camera: VirtualCamera; // TODO: perhaps only needed for players
		public var cameraLayer: MovieClip;

		public function setCameraAndLayer(camera: VirtualCamera, cameraLayer: MovieClip): void {
			this.camera = camera;
			this.cameraLayer = cameraLayer;
		}

		protected function get ReachableRooms():Array
		{
			return currentRoom.accessibleRooms;
		}	
		
		public function actAutonomously() {
			if(policy != null) {
				policy();
			}
		}

		public function die() {
			trace(this, "died")
			disableAllInteraction();
			policy = null;
			dieAnimation();
			this.currentRoom.releaseCharacter(this);
		}

		protected function dieAnimation() {throw null;}
	}
}
