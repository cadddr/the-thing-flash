package view
{
    import flash.display.MovieClip;
    import flash.events.Event;

    public class TestLevelView extends LevelView {
        
        override public function get rooms(): Array
        {
            return [room1, room2, room3, room4];
        }
    }
}