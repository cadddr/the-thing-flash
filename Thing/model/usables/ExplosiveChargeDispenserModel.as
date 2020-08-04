package model.usables
{
    import model.ThingModel;
    import model.PlayerModel;
    import model.items.ExplosiveChargeModel;

    public class ExplosiveChargeDispenserModel extends UsableModel {

        override protected function useObjectByThing(thing: ThingModel):void
        {
            
        }

        override protected function useObjectByPlayer(player: PlayerModel):void
        {
            player.equipItem(new ExplosiveChargeModel());
        }

        override public function isUsableByThing(): Boolean {
            return false;
        }

        override public function isUsableByPlayer(): Boolean {
            return true;
        }

    }
}