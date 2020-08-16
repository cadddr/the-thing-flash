package effects
{
    import flash.display.MovieClip;
    import flash.events.Event;
    import flash.geom.Point;

    public class AsciiParticleSystem extends MovieClip {
        
        public function AsciiParticleSystem(n:int, continuous:Boolean)
        {
            var particles:Array = [];
            addEventListener(Event.ADDED_TO_STAGE, function (e:Event): void {
                for(var index:int = 0; index < n; index++)
                {
                    var p = new AsciiParticle(new Point(Math.random()*800, Math.random()*600), Math.random()*2)
                    particles.push(p);
                    stage.addChild(p);
                }
            })

            if (continuous)
            {addEventListener(Event.ENTER_FRAME, function(e:Event):void {  
                for(var index:int = 0; index < n; index++) {
                    if (particles[0].ttl == 0) {
                        stage.removeChild(particles[0])
                        particles.removeAt(0);

                        var p = new AsciiParticle(new Point(Math.random()*800, Math.random()*600), Math.random()*2)
                        particles.push(p);
                        stage.addChild(p);
                    }     
                }      
                // for(var index:int = 0; index < n; index++)
                // {
                //     if (particles[index].ttl == 0) {
                //         stage.removeChild(particles[index])
                //         particles.removeAt(index);

                //         var p = new AsciiParticle(new Point(Math.random()*800, Math.random()*600), Math.random()*10)
                //         particles.push(p);
                //         stage.addChild(p);
                //     }
                // }
            })}
        }
    }
}