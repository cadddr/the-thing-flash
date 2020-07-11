package
{
	import flash.utils.*;
	import flash.display.Shape;
	
	public class Utils
	{
		public static function getRandom(max:int, min:int = 0, exclusion = -1)
		{	
			do 
			{
				var rand = Math.round(Math.random() * (max - min) + min);
			}
			while(rand == exclusion);
			
			trace("\tdice:", rand)
			
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
		
		    

		// param must be >= 1
		public static function createPoint(myx = -1, myy = -1, color = 0x00ff00):Shape
		{
			var mywidth = 1;
			var myheight = 1;
			
			if(myx == -1)
				mywidth = 100;
			if(myy == -1)
			  	myheight = 100;
				
			 var s:Shape = new Shape();
			 s.graphics.beginFill(color, 1);
			 s.graphics.drawRect(myx,myy, mywidth, myheight);
			 s.graphics.endFill();
	
			 return s;
		}
	}
}