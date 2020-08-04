package model.usables
{
    import model.ThingModel;
    import model.PlayerModel;

    public class GeneratorModel extends UsableModel {
        private var isLightOn: Boolean = true;

        override protected function useObjectByThing(thing: ThingModel):void
        {
            isLightOn = false;
        }

        override protected function useObjectByPlayer(player: PlayerModel):void
        {
            isLightOn = true;
        }

        override public function isUsableByThing(): Boolean {
            return true;
        }

        override public function isUsableByPlayer(): Boolean {
            return true;
        }
    }
}