package events
{
    import flash.events.Event;
    import characters.Character;

    public class CharacterEvent extends Event {
        public var character: Character;

        public function CharacterEvent(type: String, character: Character)
        {
            super(type);
            this.character = character;
        }
    }
}