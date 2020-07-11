package
{
	public class Utils
	{
		public static function getRandom(max:int, min:int = 0)
		{	
			
			return Math.round(Math.random() * (max - min) + min);
		}
	}
}