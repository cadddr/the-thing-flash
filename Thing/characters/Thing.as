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
	//todo: inprove ai
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
				dispatchEvent(new Event("ThingRevealed"));
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

		public function Thing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability) 
		{			
			trace("One more", this);
			this.thingKillingProbability = thingKillingProbability;
			this.thingOpenAssimilationProbability = thingOpenAssimilationProbability;
			this.thingCautiousnessLevel = thingCautiousnessLevel;
			this.humanKillingProbability = humanKillingProbability;

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

		override protected function dieAnimation() {
			gotoAndStop(23);
		}
		
		override protected function get ReachableRooms():Array
		{
			return currentRoom.adjacentRooms;
		}

		override protected function highlightForInteraction(): void {
			gotoAndPlay(2);
		}

		override protected function unhighlightForInteraction(): void {
			gotoAndStop(1);
		}
		
		
		//highlighting
		override protected function interactOnMouseOver(e:MouseEvent): void
		{
			if(GlobalState.draggableCharacter && currentRoom == GlobalState.draggableCharacter.currentRoom)
			{
				highlightForInteraction();
			}
		}
		
		override protected function interactOnMouseOut(e:MouseEvent): void
		{
				unhighlightForInteraction();
		}
		//for getting attacked by the dragged player
		//gets attacked by a dragger
		override protected function interactOnMouseUp(e:MouseEvent): void
		{
				if(GlobalState.draggableCharacter)
				   if(currentRoom == GlobalState.draggableCharacter.currentRoom)
			 	   {	
						trace(GlobalState.draggableCharacter, "is attacking", this);
						
						//dice roll should be 2 or 1
						if(Utils.getRandom(6, 1) <= humanKillingProbability)
						{
							die();
						}
						else
							gotoAndStop(1);
							
					// so he would knock off
					currentRoom.register(GlobalState.draggableCharacter as Player);
					GlobalState.draggableCharacter.finalizeAction();
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
			if(Utils.getRandom(6,1) <= thingOpenAssimilationProbability + int(this.currentRoom.IsTakenOver) * 6)
			{
				victim.getInfected(infection);
			}
		}
		
		override public function die() {
			trace(this, "died")
			super.die();
			IsVisible = true;
			dieAnimation();
		}
		
		private function attack(victim:Player)
		{
			trace(this, "is attacking", victim);
			
			if(Utils.getRandom(6, 1) <= thingKillingProbability)
				victim.die();
		}
				
		private function goToRandomReachableRoom()
		{
			trace(this, "is moving to a random reachable room");
			var randomRoom = Utils.getRandom(ReachableRooms.length - 1);
			ReachableRooms[randomRoom].register(this);
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
			ReachableRooms[randomRoom].register(this);
		}
		
		private function goToLeastPopulatedRoom()
		{
			var leastPopulatedRoom:RoomBase = ReachableRooms[0];
			
			for(var i:int = 0; i < ReachableRooms.length; i++)
			{
				trace(this, "is deciding on where to go");
				if(Utils.getRandom(6, 1) > ReachableRooms[i].PlayerMargin * thingCautiousnessLevel)	
					leastPopulatedRoom = ReachableRooms[i];
			}
			
			leastPopulatedRoom.register(this);
		}
		
		
	}
	
}
