package model.items
{
    public class ExplosiveChargeModel extends ItemModel {
        private var isCharged: Boolean = false;

        override public function isDroppable(): Boolean {
            return true;
        }
    }
}