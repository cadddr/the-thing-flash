package  {
	
	import flash.display.MovieClip;
	import flash.events.*;
    import flash.geom.Rectangle;
    import flash.geom.ColorTransform;
	import GlobalState;
	import Character;
	
	public class Player extends Character
	{						
		private var alreadyActed:Boolean = false;		
		private var isInfected:Boolean = false;
		
		public function get IsInfected()
		{
			return isInfected;
		}
		
		public function set IsInactive(value)
		{
			if(value)
				gotoAndStop(23);
			else 
				gotoAndStop(1);
			
			alreadyActed = value;
		}
		
		public function get IsInactive():Boolean
		{
			return alreadyActed;
		}
		
		
		public function Player() 
		{							
			//dragging
			addEventListener(MouseEvent.MOUSE_DOWN, drag);
			// mouse up handled by stage
			
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, highlight);
			addEventListener(MouseEvent.MOUSE_OUT, unhighlight);		

			transform.colorTransform = new ColorTransform(0, 0, 0, 1, Math.random() * 255, Math.random() * 255, Math.random() * 255);
			
			reachabilityMap = GlobalState.playerReachabilityMap;
		}		
		
		public function equipSyringe()
		{
			trace(this, "has equipped syringe")
			this.mysyringe.visible = true;
			this.mysyringe.owner = this;
		}
		
		public function equipExplosiveCharge()
		{
			trace(this, "has equipped explosive charge")
			this.mycharge.visible = true;
			this.mycharge.owner = this;
		}
		
		public override function toString():String
		{
			return "Player " + this.transform.colorTransform.color.toString(16);
		}
		
		private function highlight(e:MouseEvent)
		{
			if(!alreadyActed)
				gotoAndPlay(2);
		}
		
		private function unhighlight(e:MouseEvent)
		{
			if(!alreadyActed)
				gotoAndPlay(1);
		}
		
		private function drag(e:MouseEvent)
		{
			if(!alreadyActed)
			{
				if(this.isInfected)
				{	
					trace("Is", this, "going to refuse to execute the order?");
					if(Utils.getRandom(6,1) <= GlobalState.humanInfectedRefusalProbability)
						this.revealItself();
				}
				
				else
				{				
					highlightReachableRooms();
				
					initializeAction();
				}
			}
		}
		
		public function getInfected(infection:Function)
		{
			trace(this, "got infected");
			
			if(GlobalState.DEBUG)
				this.Visible = false;
			
			policy = infection;
			
			if(infection != null)
				isInfected = true;
		}
		
		public function revealItself()
		{
			if (isInfected)
			{
				var revealedThing = new Thing();
				GlobalState.things.push(revealedThing);
				stage.addChild(revealedThing);
				
				var tmpX = this.x;
				var tmpY = this.y;
				
				var tmpRoom = this.currentRoom;
				
				this.die();
				stage.removeChild(this);
				
				tmpRoom.putIn(revealedThing);
				
				revealedThing.x = tmpX;
				revealedThing.y = tmpY;
				
				revealedThing.goVisible();
													
				//assuming the thing will act after players act
			}
		}
				
		
		override public function die()
		{
			trace(this, "died");
			
			super.die()
			gotoAndStop(24);
			//for not acting anymore
			alreadyActed = true;
			
			GlobalState.players.splice(GlobalState.players.indexOf(this), 1);			
		}
		
		private function initializeAction()
		{
			GlobalState.draggableCharacter = this;	
			startDrag();	
			
			
			mouseEnabled = false;
		}
		
		public function finalizeAction()
		{			
			IsInactive = true;
			stopDrag();
			
			GlobalState.draggableCharacter = null;
			mouseEnabled = true;
			
			
		}
		
		private function highlightReachableRooms() 
		{			
			ReachableRooms.forEach(function(room:*) {room.highlightReachable()});
		}
		
	}
	
}
