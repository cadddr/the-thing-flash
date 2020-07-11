package 
{
	import Thing;
	public class Policy 
	{
		public static function generateThingPolicy(forWhom:Thing)
		{
			return function()
			{					
				if (this.currentRoom is GenRoom && GlobalState.isLightOn)
					this.currentRoom.lightSwitch.switchPower(false);
				else
				{
					var potentialVictims = currentRoom.characters.filter(function(item:*){return item is Player && (!item.IsInfected)});
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
							if(Utils.getRandom(6, 1) > currentRoom.PlayerMargin * 2)						
								attack(victim)
							else												
								goToAnotherRandomReachableRoom();					
						}									
					}				
					else
						goToRandomReachableRoom();
				}
			}
		}
		
	}
}