package model
{
    import characters.Player;
    import model.items.ItemModel;

    public class PlayerModel extends CharacterModel {
        protected var isInfected: Boolean = false;
        private var equippedItems: Array = [];

        public function equipItem(item: ItemModel) {
            
        }
    }
}