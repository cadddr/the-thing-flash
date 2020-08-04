package characters {
	import flash.display.MovieClip;
	import GlobalState;
	import rooms.Room;
	import characters.Interactable;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	import asciiRooms.AsciiRoomBase;
	import fl.VirtualCamera;
	import flash.geom.Point;
	
	public class Character extends Interactable {
		
		public var policy:Function = null;
		public var currentRoom:Room = null;
		public var previousRoom:Room = null;
		
		

		private var camera: VirtualCamera;

		public function setCamera(camera: VirtualCamera): void {
			this.camera = camera;
		}
		
		public function set IsVisible(value:Boolean)
		{
			if(value)
				alpha = 1;
			else if(GlobalState.DEBUG)
				alpha = 0.3;
		}
		
		protected function dieAnimation() {
		}

		public function moveTo(x:Number, y:Number) {
			if (camera != null) {
				camera.pinCameraToObject(this);
			}
			
			gotoAndPlay(1);

			var tweenX: Tween = new Tween(this, "x", Strong.easeInOut, this.x, x, 24);
			var tweenY: Tween = new Tween(this, "y", Strong.easeInOut, this.y, y, 24);

			tweenX.addEventListener(TweenEvent.MOTION_CHANGE, function(e:TweenEvent) {
				AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, e.position, y);
			})

			tweenY.addEventListener(TweenEvent.MOTION_CHANGE, function(e:TweenEvent) {
				AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, e.position);
			})

			if (Math.abs(x - this.x) > Math.abs(y - this.y)) {
				tweenY.stop();
				tweenX.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {
					tweenY.start()
				});
				
				tweenY.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {stop();});

			}
			else {
				tweenX.stop();
				tweenY.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {tweenX.start()});
				tweenX.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {stop();});
			}

		}
		
		protected function get ReachableRooms():Array
		{
			return currentRoom.accessibleRooms;
		}
		
		
		public function Character()
		{
			scaleX = 1;
			scaleY = 1;
		}
		
		public function act()
		{
			if (!isDead)
			{
				if(policy != null)
					{
						policy();
					}
			}
		}
		
		public function die()
		{
			leaveRoom();
		}
		
		public function leaveRoom()
		{
			if (currentRoom)
			{
				currentRoom.highlightReachableRooms(false);
				previousRoom = currentRoom;
				
				currentRoom.getOut(this);				
			}
		}
	}
	
}
