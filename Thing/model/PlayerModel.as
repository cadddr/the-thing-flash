package model
{
    import characters.Player;
    import model.items.ItemModel;

    public class PlayerModel extends CharacterModel {
        protected var isInfected: Boolean = false;
        private var equippedItems: Array = [];
        private var _id:int;

        public function PlayerModel(id:int)
        {
            this._id = id;
        }

        override public function get id():Object
        {
            return this._id;
        }

        public function equipItem(item: ItemModel) {

        }
    }
}