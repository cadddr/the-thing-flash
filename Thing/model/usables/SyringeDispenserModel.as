package model.usables
{
    import items.Syringe;
    import model.items.SyringeModel;
    import model.ThingModel;
    import model.PlayerModel;

    public class SyringeDispenserModel extends UsableModel {

        override protected function useObjectByThing(thing: ThingModel):void
        {
            
        }

        override protected function useObjectByPlayer(player: PlayerModel):void
        {
            player.equipItem(new SyringeModel());
        }

        override public function isUsableByThing(): Boolean {
            return false;
        }

        override public function isUsableByPlayer(): Boolean {
            return true;
        }

    }
}