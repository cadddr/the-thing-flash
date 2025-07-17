package events {
    import flash.events.Event;
    import characters.Character;
    import rooms.RoomBase;

    public class CharacterEvent extends Event {
        public var character: Character;
        public var room: RoomBase;

        public function CharacterEvent(type: String, character: Character, room: RoomBase) {
            super(type);
            this.character = character;
            this.room = room;
        }
    }
}