package model
{
    public class LevelModel {
        protected var maxPlayers: int;
        public var rooms: Array;
        public var initialized: Boolean = false;

        protected var _players:Array = [];
        
        public function get players():Array
        {
            return _players;
        }

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


        private function findCharacterRoom(charId: int): int {
            for(var roomId:int = 0; roomId < rooms.length; roomId++)
            {
                for each(var guest:CharacterModel in rooms[roomId].guests)
                {
                   if (charId == guest.id) {
                       return roomId;
                   } 
                }
            }
            return -1;
        }

        public function putCharInRoom(character: CharacterModel, roomId: int): void {
            var room: RoomModel = rooms[roomId];
            room.guests.push(character);
        }

        public function moveCharToRoom(playerId: int, targetRoomId: int): Boolean {
            var currentRoomId: int = findCharacterRoom(playerId);

            if (playerReachabilityMap[currentRoomId][targetRoomId] == 1) {
                rooms[currentRoomId].guests.remove(players[playerId]);
                rooms[targetRoomId].guests.push(players[playerId]);
                players[playerId].alreadyActed = true;
                return true;
            }

            return false;
        }




        public function initializeCharacterModels(): void {
            if (initialized) return;

            var initialRoom: int = Math.round(Math.random() * (numRooms - 1));

            for (var i: int = 0; i < numMaxPlayers; i++) {
                var playerModel: PlayerModel = new PlayerModel(i);

                _players.push(playerModel);
                putCharInRoom(playerModel, initialRoom);
            }

            var thingsInitialRoom: int = Math.round(Math.random() * (numRooms - 1));
            if (thingsInitialRoom == initialRoom) {
                thingsInitialRoom = (thingsInitialRoom + 1) % numRooms;
            }

            var thingModel: ThingModel = new ThingModel();

            putCharInRoom(thingModel, thingsInitialRoom);
            
            initialized = true;
        }

    }


}