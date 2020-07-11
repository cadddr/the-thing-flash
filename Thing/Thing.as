package  {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import GlobalState;
	
	public class Thing extends MovieClip {
		
		//todo: normalize
		private const killProbability:Number = 3;
		public var currentRoom:Room;
		
		private var isDead:Boolean;
		private var isVisible:Boolean;
		
		public function Thing() 
		{			
			currentRoom = null;
			isDead = false;
			goInvisible();
			
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);			
			
			//for getting attacked by the dragged player
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}
		
		
		public function set IsDead(value)
		{
			if (value)
			{
				gotoAndStop(22);
				isDead = true;
				mouseEnabled = false;
			}
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
		
		//gets killer by a dragger
		private function onMouseUp(e:MouseEvent)
		{
			if(!isDead)
				if(GlobalState.draggableCharacter)
				   if(currentRoom == GlobalState.draggableCharacter.currentRoom)
			 	   {	
						//dice roll should be 2 or 1
						var killingDice = Utils.getRandom(6, 1);
						trace("killing dice:", killingDice);
						
						if(killingDice <= GlobalState.draggableCharacter.killProbability)
						{
							IsDead = true;
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
		}
		
		public function goInvisible()
		{
			if(!isDead)
			{
				isVisible = false;
				if(GlobalState.DEBUG)
					alpha = 0.2;
				else
					alpha = 0;
			}
		}
		
		public function act()
		{
			if(!isDead)
			{
				var potentialVictims = currentRoom.characters.filter(function(item:*){return item is Player && (!item.IsInfected)});
				if(potentialVictims.length > 0)
				{
					var victim = potentialVictims[Utils.getRandom(potentialVictims.length - 1)];
					
					if(currentRoom.IsTakenOver)
					{					
						assimilate(victim);
					}
				
					//also a random chance of engaging in open fight
					//has to do with player's killing probability
					else if(Utils.getRandom(6, 1) > currentRoom.PlayerMargin)
					{
						attack(victim);
					}
					
					else
					{						
						goToRandomReachableRoom();
					}
				}				
				else
					goToRandomReachableRoom();
			}
		}
		
		private function assimilate(victim:Player)
		{
			//infection to be communicated to victim
			var infection:Function = function()
			{				
				var checkNonInfectedPlayers:Function = function(item:*)
				{
					return item is Player && (!item.IsInfected)
				}				
				
				var potentialVictims = this.currentRoom.characters.filter(checkNonInfectedPlayers);
				trace("Infected in:", this.currentRoom, "potential victims:", potentialVictims.length)
				
				if(this.currentRoom.IsTakenOver && potentialVictims.length > 0)
				{
					potentialVictims[Utils.getRandom(potentialVictims.length - 1)].IsInfected = infection;
				}
			}
			
			victim.IsInfected = infection;
		}
		
		private function attack(victim:Player)
		{
			if(Utils.getRandom(6, 1) <= killProbability)
				victim.die();
		}
		
		private function get ReachableRooms()
		{
			var originRoomIndex:int = 0;
			
			if (currentRoom is Room1)
				originRoomIndex = 0			
			
			else if (currentRoom is GenRoom)
				originRoomIndex = 1
				
			else if (currentRoom is Room3)
				originRoomIndex = 2
				
			else if (currentRoom is AmmoRoom)
				originRoomIndex = 3
			
			else if (currentRoom is TestRoom)
				originRoomIndex = 4
				
			else if (currentRoom is Room6)
				originRoomIndex = 5
				
			else if (currentRoom is Room7)
				originRoomIndex = 6
				
			else if (currentRoom is Room8)
				originRoomIndex = 7;
			
			
			var passabilityList = GlobalState.adjacencyMap[originRoomIndex];
			var reachableRooms:Array = []
				for(var i:int = 0; i < passabilityList.length; i++)
				{
					if (passabilityList[i] == 1)
					{
						reachableRooms.push(GlobalState.rooms[i])
					}
				}
				
			return reachableRooms;
		}
		
		private function goToRandomReachableRoom()
		{
			var randomRoom = Utils.getRandom(ReachableRooms.length - 1);
			ReachableRooms[randomRoom].putIn(this);
		}
	}
	
}
