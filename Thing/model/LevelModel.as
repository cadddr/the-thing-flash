package model
{
    public class LevelModel {
        protected var maxPlayers: int;
        protected var rooms: Array;
        

        protected var playerReachabilityMap: Array = [
			[]
		];

		protected var thingReachabilityMap: Array = [
			[]
		];

        public function get numRooms(): int
        {
            return rooms.length;
        }

        public function get numMaxPlayers(): int
        {
            return maxPlayers;
        }

        public function putCharInRoom(character: CharacterModel, roomId: int): void {

        }

    }


}