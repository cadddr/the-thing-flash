package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import GlobalState;
	import Character;
	import Room;
	import flash.events.Event;
	
	public class Thing extends Character 
	{		
		public var isVisible:Boolean;
		private var switchLightRetries = 2;
		
		public function set IsDead(value)
		{
			if (value)
			{
				gotoAndStop(23);
				isDead = true;
				mouseEnabled = false;
				this.goVisible();
			}
		}
		
		public function Thing() 
		{			
			trace("One more", this);
			
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);			
			
			//for getting attacked by the dragged player
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
			reachabilityMap = GlobalState.thingReachabilityMap;
			
			policy = function()
			{				
				//so it wouldn't compete with players at switching the light
				if (this.currentRoom is GenRoom && GlobalState.isLightOn && switchLightRetries > 0)
				{
					this.currentRoom.lightSwitch.switchPower(false);
					switchLightRetries--;
				}
				else
				{
					switchLightRetries++;
					var potentialVictims = currentRoom.NonInfectedPlayers;
					if(potentialVictims.length > 0)
					{
						trace(this, "is choosing whom to assimilate")
						var victim = potentialVictims[Utils.getRandom(potentialVictims.length - 1)];
						
						if(currentRoom.IsTakenOver || !GlobalState.isLightOn)
						{					
							assimilate(victim);
						}					
						//also a random chance of engaging in open fight
						//has to do with player's killing probability						
						else 
						{
							trace(this, "is deciding on whether to engage in an open fight");
							if(Utils.getRandom(6, 1) > currentRoom.NonInfectedPlayerMargin * GlobalState.thingCautiousnessLevel)						
								attack(victim)
							else												
								goToAnotherRandomReachableRoom();		
								//goToLeastPopulatedRoom();
						}									
					}				
					else
						//goToLeastPopulatedRoom()
						goToAnotherRandomReachableRoom();
				}
			}
			/////////////////////////
			
			
			goInvisible();
		}
		
		private function onMouseOver(e:MouseEvent)
		{
			if(!isDead)
				if(GlobalState.draggableCharacter && currentRoom == GlobalState.draggableCharacter.currentRoom)
					gotoAndPlay(2);
		}
		
		private function onMouseOut(e:MouseEvent)
		{
			if(!isDead)
				gotoAndStop(1);
		}
		
		//gets attacked by a dragger
		private function onMouseUp(e:MouseEvent)
		{
			if(!isDead)
				if(GlobalState.draggableCharacter)
				   if(currentRoom == GlobalState.draggableCharacter.currentRoom)
			 	   {	
						trace(GlobalState.draggableCharacter, "is attacking", this);
						
						//dice roll should be 2 or 1
						if(Utils.getRandom(6, 1) <= GlobalState.humanKillingProbability)
						{
							die();
						}
						else
							gotoAndStop(1);
							
					currentRoom.putIn(GlobalState.draggableCharacter as Player);
					GlobalState.draggableCharacter.finalizeAction();
			}
		}
		
		public function goVisible()
		{
			isVisible = true;
			alpha = 1;
			this.mouseEnabled = true;
			
			dispatchEvent(new Event("ThingRevealed"));
		}
		
		public function goInvisible()
		{
			if(!isDead)
			{
				isVisible = false;
				if(GlobalState.DEBUG)
					alpha = 0.3;
				else
					alpha = 0;
					
				this.mouseEnabled = false;
			}
		}
		
		public function refreshVisibility()
		{
			if (currentRoom.IsTakenOver || !GlobalState.isLightOn)
			{
				goInvisible();
			}
			else
			{
				goVisible();
			}
		}
		
		
		private function assimilate(victim:Player)
		{
			//infection to be communicated to victim
			var infection:Function = function()
			{				
				var potentialVictims = this.currentRoom.Players;
				trace("Infected", this, "in", this.currentRoom, "\n\tpotential victims:", potentialVictims.length)
				
				if(this.currentRoom.IsTakenOver)
				{
					if(potentialVictims.length > 0)
					{
						trace(this, "is choosing whom to assimilate")
						potentialVictims[Utils.getRandom(potentialVictims.length - 1)].getInfected(infection);
					}
				}
				else
				{					
					//this.revealItself();				
					
				}
				
			}
			
			trace(this, "is trying to assimilate into", victim);
			if(Utils.getRandom(6,1) <= GlobalState.thingOpenAssimilationProbability + int(this.currentRoom.IsTakenOver) * 6)
			{
				victim.getInfected(infection);
			}
		}
		
		override public function die()
		{
			trace(this, "died")
			IsDead = true;
			super.die();
		}
		
		private function attack(victim:Player)
		{
			trace(this, "is attacking", victim);
			
			if(Utils.getRandom(6, 1) <= GlobalState.thingKillingProbability)
				victim.die();
		}
				
		private function goToRandomReachableRoom()
		{
			trace(this, "is moving to a random reachable room");
			var randomRoom = Utils.getRandom(ReachableRooms.length - 1);
			ReachableRooms[randomRoom].putIn(this);
		}
		
		//todo: has to see if there are players in reachable rooms
		private function goToAnotherRandomReachableRoom()
		{
			trace(this, "is moving to a different room");
			var currentRoomIndex = ReachableRooms.indexOf(currentRoom);
			var randomRoom = Utils.getRandom(ReachableRooms.length - 1, 0, currentRoomIndex);
			ReachableRooms[randomRoom].putIn(this);
		}
		
		private function goToLeastPopulatedRoom()
		{
			var leastPopulatedRoom:Room = ReachableRooms[0];
			
			for(var i:int = 0; i < ReachableRooms.length; i++)
			{
				trace(this, "is deciding on where to go");
				if(Utils.getRandom(6, 1) > ReachableRooms[i].PlayerMargin * GlobalState.thingCautiousnessLevel)	
					leastPopulatedRoom = ReachableRooms[i];
			}
			
			leastPopulatedRoom.putIn(this);
		}
		
		
	}
	
}
