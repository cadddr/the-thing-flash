package characters {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import GlobalState;
	import characters.*;
	import rooms.*;
	import flash.events.Event;
	import rooms.RoomBase;
	import items.GeneratorSwitch;
	
	// TODO: revamp AI logic
	public class Thing extends Character 
	{		
		private var switchLightRetries = 2;

		protected var thingKillingProbability: Number;
		protected var thingOpenAssimilationProbability: Number;
		protected var thingCautiousnessLevel: Number;
		protected var humanKillingProbability: Number;

		private var isVisible:Boolean;
		public function get IsVisible(): Boolean {
			return isVisible;
		}

		public function set IsVisible(value: Boolean) {
			trace(this, value ? "is revealed" : "disappears")
			isVisible = value;
			this.mouseEnabled = true;
			
			if (value) {
				alpha = 1;
				dispatchEvent(new Event("ThingRevealed")); // not used now but maybe could be subscribed by players to react
			}
			else {
				if(GlobalState.DEBUG)
					alpha = 0.3;
				else
					alpha = 0;
			}
		}
		
		public function refreshVisibility() {
			trace ("visibility check at", currentRoom)
			IsVisible = !currentRoom.IsTakenOver && GlobalState.isLightOn
		}

		override protected function get ReachableRooms():Array {
			return currentRoom.adjacentRooms;
		}

		public function Thing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability) 
		{			
			trace("One more", this);
			this.thingKillingProbability = thingKillingProbability;
			this.thingOpenAssimilationProbability = thingOpenAssimilationProbability;
			this.thingCautiousnessLevel = thingCautiousnessLevel;
			this.humanKillingProbability = humanKillingProbability;

			// random walk until run into generator room or room with other players
			// if in generator can be switched off try several times
			// if there are players either assimilate (if invisible) or try to openly fight
			// otherwise flee to random room
			policy = function()
			{				
				//so it wouldn't compete with players at switching the light
				if (findLightSwitchInRoom(currentRoom) != null && GlobalState.isLightOn && switchLightRetries > 0)
				{
					findLightSwitchInRoom(currentRoom).switchPower();
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
							if(Utils.getRandom(6, 1) > currentRoom.NonInfectedPlayerMargin * thingCautiousnessLevel)						
								attack(victim)
							else	{											
								goToAnotherRandomReachableRoom();		
								//goToLeastPopulatedRoom();
							}
						}									
					}				
					else {
						// goToLeastPopulatedRoom()
						goToAnotherRandomReachableRoom();
					}
				}
			}
			/////////////////////////
			
			IsVisible = false;
		}

		protected function findLightSwitchInRoom(room: RoomBase): GeneratorSwitch {
			for each(var item:Interactable in room.interactables)
			{
				if (item is GeneratorSwitch) {
					return GeneratorSwitch(item);
				}
			}
			// var foundItems: Array = room.interactables.filter(function(x:Interactable):Boolean {
			// 	return x is GeneratorSwitch
			// });
			// if (foundItems.length == 0) {
			// 	return null;
			// }
			// return foundItems[0];
			return null;
		}

		// could stay in same room
		private function goToRandomReachableRoom()
		{
			trace(this, "is moving to a random reachable room");
			var randomRoom = Utils.getRandom(ReachableRooms.length - 1);
			ReachableRooms[randomRoom].moveCharacterToRoom(this);
		}
		
		//todo: has to see if there are players in reachable rooms
		private function goToAnotherRandomReachableRoom()
		{
			trace(this, "is moving to a different room");
			var currentRoomIndex = ReachableRooms.indexOf(currentRoom);
			var randomRoom = Utils.getRandom(ReachableRooms.length - 1, 0, currentRoomIndex);
			//invalidate, so that its location is regenerated
			x=0;
			y=0;
			ReachableRooms[randomRoom].moveCharacterToRoom(this);
		}
		
		// seems unused, broken?
		private function goToLeastPopulatedRoom()
		{
			var leastPopulatedRoom:RoomBase = ReachableRooms[0];
			
			for(var i:int = 0; i < ReachableRooms.length; i++)
			{
				trace(this, "is deciding on where to go");
				if(Utils.getRandom(6, 1) > ReachableRooms[i].PlayerMargin * thingCautiousnessLevel)	
					leastPopulatedRoom = ReachableRooms[i];
			}
			
			leastPopulatedRoom.moveCharacterToRoom(this);
		}

		private function assimilate(victim:Player)
		{
			// infection to be communicated to victim
			// infected victim can quietly infect others when left alone with them without doing any other thing stuff
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
			if(Utils.getRandom(6,1) <= thingOpenAssimilationProbability + int(this.currentRoom.IsTakenOver) * 6)
			{
				victim.getInfected(infection);
			}
		}

		private function attack(victim:Player)
		{
			trace(this, "is attacking", victim);
			
			if(Utils.getRandom(6, 1) <= thingKillingProbability)
				victim.die();
		}
		
		protected function getAttackedByPlayer(): void {
			if(GlobalState.draggableCharacter)
				if(currentRoom == GlobalState.draggableCharacter.currentRoom)
				{	
					trace(this, "is being attacked by", GlobalState.draggableCharacter);
					if (GlobalState.draggableCharacter) { //TODO:
						AsciiPlayer(GlobalState.draggableCharacter).weaponAnimation();
					}
					//dice roll should be 2 or 1
					if(Utils.getRandom(6, 1) <= humanKillingProbability)
					{
						die();
					}
					else
						unhighlightForInteraction();
						
				// so he would knock off
				// currentRoom.moveCharacterToRoom(GlobalState.draggableCharacter as Player);
				GlobalState.draggableCharacter.finalizeAction();
			}
		}
		
		override public function die() {
			IsVisible = true;
			super.die();
		}		
	}
}
