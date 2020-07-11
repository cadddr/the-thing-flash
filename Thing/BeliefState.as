package  {
	import flash.utils.Dictionary;
	import flash.display.MovieClip;
	
	public class BeliefState extends MovieClip
	{
		public var p;
		//suspect - infected pairs
		private var suspects:Dictionary = new Dictionary();
		
		public function BeliefState(suspects:Array, p:Number) 
		{
			this.p = p;
			
			for (var i:int = 0; i < suspects.length; i++)
			{
				this.suspects[suspects[i]] = 0;
			}
		}
		
		public override function toString():String
		{
			var string = "Belief state, p = " + p + "\n";
			
			for (var suspect:* in this.suspects)
			{
				string += "\t" + suspect + "\t" + this.suspects[suspect] + "\n";
			}
			return string;
		}

	}
	
}
