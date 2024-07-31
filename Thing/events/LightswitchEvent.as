package events
{
    import flash.events.Event;

    public class LightswitchEvent extends Event {
        public var isLightOn: Boolean;

        public function LightswitchEvent(type: String, isLightOn: Boolean)
        {
            super(type);
            this.isLightOn = isLightOn;
        }
    }
}