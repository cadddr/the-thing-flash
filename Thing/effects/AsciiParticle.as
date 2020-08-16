package effects
{
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.geom.Point;
    import flash.events.Event;
    import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;

    public class AsciiParticle extends TextField {
        var heading: Point;
        public var ttl: int;

        var tweenX: Tween;
        var tweenY: Tween;
        var tweenAlpha: Tween;
        
        public function AsciiParticle(heading: Point, ttl: int)
        {
            text = ".";
            selectable = false;
            textColor = 0xffff00;
            background = false;

            this.heading = heading;
            this.ttl = ttl;
        //    addEventListener(Event.ENTER_FRAME, function(e:Event): void {
            // x=400;
            // y=300;

        //    })

        var caller = this
            addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
                tweenX = new Tween(caller, "x", Strong.easeInOut, caller.x, heading.x, caller.ttl, true);
                tweenY = new Tween(caller, "y", Strong.easeInOut, caller.y, heading.y, caller.ttl, true);
                tweenAlpha = new Tween(caller, "alpha", Strong.easeInOut, caller.alpha, 0, caller.ttl, true);
                tweenAlpha.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent): void {caller.ttl=0;});
            })
        
        }
        
    }
}