package
{
	import flash.utils.*;
	
	public class Utils
	{
		public static function getRandom(max:int, min:int = 0, exclusion = -1)
		{	
			do 
			{
				var rand = Math.round(Math.random() * (max - min) + min);
			}
			while(rand == exclusion);
			
			return  rand;
		}
		
		public static function sleep(ms:int)
		{    		
			var init:int = getTimer();
			
			while(true) 
			{
        		if(getTimer() - init >= ms) 
				{
            		break;
        		}
    		}
		}
	}
}