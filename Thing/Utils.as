package
{
	import flash.utils.*;
	import flash.geom.ColorTransform;
	import fl.motion.Color;
	import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
	import fl.motion.BezierSegment;
	import flash.geom.Point;

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

		public static var currentTween: Tween = null;

		public static function tweenValueAndFinish(caller: Object, propname: String, easing: Function, start: Number, value: Number, duration: Number, onChange: Function, onFinish: Function) {
			var tween: Tween = new Tween(caller, propname, easing, start, value, duration, true);
			currentTween = tween;
			// trace ('tween set')
			tween.addEventListener(TweenEvent.MOTION_CHANGE, onChange);
			tween.addEventListener(TweenEvent.MOTION_FINISH, onFinish);
			tween.start();
		}


		public static function tweenValue(caller: Object, propname: String, easing: Function, start: Number, value: Number, duration: Number, onChange: Function) {
			
			tweenValueAndFinish(caller, propname, easing, start, value, duration, onChange, 
				function(e:TweenEvent): void {
					// trace ('tween finished'); 
					currentTween = null
				});
		}

		static var tweens: Array;
		public static function tweenValueSteppedAndFinish(caller, propname, easing: Function, stepValues: Array, duration: Number, onChange: Function, onFinish: Function) {
			var getNextTweenFunc = function(tweens, i) {
				return function(e:*) {
					tweens[i + 1].start()
				};
			}

			tweens = [];
			for (var step:int = 1; step < stepValues.length; step++) {
				var tween:Tween = new Tween({"x": 0}, "x", Regular.easeInOut, stepValues[step - 1], stepValues[step], duration, true);
				tween.stop();
				tween.addEventListener(TweenEvent.MOTION_CHANGE, onChange);
				tweens.push(tween);
			}
			
			for (var i = 0; i < (tweens.length - 1); i++) {
				tweens[i].addEventListener(TweenEvent.MOTION_FINISH, getNextTweenFunc(tweens, i));
			}
			tweens[tweens.length - 1].addEventListener(TweenEvent.MOTION_FINISH, onFinish);
			tweens[0].start()
		}

		/// Bezier utils
		public static function bezierLength(segment:BezierSegment, steps:int = 100):Number {
			var length:Number = 0;
			var prevPoint:Point = segment.getValue(0);
			
			for (var i:int = 1; i <= steps; i++) {
				var t:Number = i / steps;
				var currentPoint:Point = segment.getValue(t);
				length += Point.distance(prevPoint, currentPoint);
				prevPoint = currentPoint;
			}
			
			return length;
		}

		static function createArcLengthMap(segment:BezierSegment, steps:int = 100):Array {
			var map:Array = [];
			var totalLength:Number = 0;
			var prevPoint:Point = segment.getValue(0);
			
			map.push({t: 0, length: 0});
			
			for (var i:int = 1; i <= steps; i++) {
				var t:Number = i / steps;
				var currentPoint:Point = segment.getValue(t);
				totalLength += Point.distance(prevPoint, currentPoint);
				map.push({t: t, length: totalLength});
				prevPoint = currentPoint;
			}
			
			return map;
		}

		static function getTFromArcLength(arcLengthMap:Array, targetLength:Number):Number {
			var totalLength:Number = arcLengthMap[arcLengthMap.length - 1].length;
			var normalizedTarget:Number = targetLength / totalLength;
			
			for (var i:int = 1; i < arcLengthMap.length; i++) {
				var prevNormalized:Number = arcLengthMap[i-1].length / totalLength;
				var currentNormalized:Number = arcLengthMap[i].length / totalLength;
				
				if (normalizedTarget >= prevNormalized && normalizedTarget <= currentNormalized) {
					var ratio:Number = (normalizedTarget - prevNormalized) / (currentNormalized - prevNormalized);
					return arcLengthMap[i-1].t + ratio * (arcLengthMap[i].t - arcLengthMap[i-1].t);
				}
			}
			
			return 1; // Return 1 if we somehow exceed the total length
		}

		public static function getTValuesForSteps(trajectory, numSteps, stepSize) {
			var map = createArcLengthMap(trajectory)
			var stepValues = []
			stepValues.push(0.)
			for (var step:int = 1; step <= numSteps; step++) {
				var t = getTFromArcLength(map, step * stepSize)
				stepValues.push(t)
			}
			return stepValues;
		}
		/// End Bezier utils


	}
}
