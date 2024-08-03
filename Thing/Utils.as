package
{
	import flash.utils.*;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;

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

		public static function scaleTransformColor(color: uint, multiplier: Number, f: Function): uint {
			var albedoRgba = new Color();
			albedoRgba.tintColor = color;
			albedoRgba.tintMultiplier = multiplier;

			var scaledColor = new ColorTransform(0,0,0,1,
                f(albedoRgba.redOffset),
                f(albedoRgba.greenOffset),
                f(albedoRgba.blueOffset)
			)
			
			return scaledColor.color;
		}

		public static function scaleColor(color: uint, multiplier: Number): uint {
			return scaleTransformColor(color, multiplier, function (x: uint): Number {return x;});
		}

		public static function tweenValueAndFinish(caller: Object, propname: String, easing: Function, start: Number, value: Number, duration: Number, onChange: Function, onFinish: Function) {
			var tween: Tween = new Tween(caller, propname, easing, start, value, duration, true);
			tween.addEventListener(TweenEvent.MOTION_CHANGE, onChange);
			tween.addEventListener(TweenEvent.MOTION_FINISH, onFinish);
			tween.start();
		}


		public static function tweenValue(caller: Object, propname: String, easing: Function, start: Number, value: Number, duration: Number, onChange: Function) {
			tweenValueAndFinish(caller, propname, easing, start, value, duration, onChange, function(e:TweenEvent): void {});
		}
	}
}
