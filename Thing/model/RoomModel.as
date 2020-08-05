package model
{
    import characters.Thing;
    import characters.Player;

    public class RoomModel {
        public var guests: Array = [];
        private var usables: Array = [];


        public function RoomModel(usables: Array) {
            this.usables = usables;
        }

        public function get Things(): Array {
			return guests.filter(function (item: * ) {
				return item is ThingModel
			});
		}

		public function get Players(): Array {
			return guests.filter(function (item: * ) {
				return item is PlayerModel
			});
		}

        
    }
}