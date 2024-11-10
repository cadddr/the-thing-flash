package characters {
    import flash.display.MovieClip;
    import flash.text.TextField;
    import flash.utils.Timer;
    import flash.events.TimerEvent;

    public class AsciiCharacter extends MovieClip {
        // private var asciiText:TextField;
        private var animationTimer:Timer;
        private var currentAnimation:String = "attack";
        private var animationFrame:int = 0;

        public function AsciiCharacter() {
            // asciiText = new TextField();
            // addChild(asciiText);
            
            animationTimer = new Timer(100); // 200ms between frames
            animationTimer.addEventListener(TimerEvent.TIMER, updateAnimation);
            animationTimer.start();
        }

        public function setAnimation(animType:String):void {
            currentAnimation = animType;
            animationFrame = 0;
        }

        private function updateAnimation(event:TimerEvent):void {
            // y-=5;
            switch(currentAnimation) {
                case "idle":
                    asciiText.text = "|o|";
                    break;
                case "walk":
                    var walkFrames:Array = [",o'", "-o-", "'o,", "-o-"];
                    asciiText.text = walkFrames[animationFrame % walkFrames.length];
                    break;
                case "attack":
                    var attackFrames:Array = ["o-", "o==", "o=≡", "o-*"];
                    asciiText.text = attackFrames[animationFrame % attackFrames.length];
                    break;
                case "infected":
                    var infectedFrames:Array = [",o,", ".o.", "~o~", "¿o¿", "&o&"];
                    asciiText.text = infectedFrames[animationFrame % infectedFrames.length];
                    break;
                case "flamethrower":
                    asciiText.text = "o=≡~";
                    break;
            }
            animationFrame++;
        }

        public function setColor(color:uint):void {
            asciiText.textColor = color;
        }
    }
}