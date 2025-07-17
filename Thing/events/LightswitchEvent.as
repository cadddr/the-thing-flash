package events
{
    import flash.events.Event;
    import characters.Character;

    public class LightswitchEvent extends Event {
        public var isLightOn: Boolean;
        public var character: Character;

        public function LightswitchEvent(type: String, isLightOn: Boolean, character: Character)
        {
            super(type);
            this.isLightOn = isLightOn;
            this.character = character;
        }
    }
}