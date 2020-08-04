package model.usables
{
    import model.CharacterModel;
    import model.ThingModel;
    import model.PlayerModel;

    public class UsableModel {
        public function useObject(user: CharacterModel):void {
            if (isUsableByThing() && user is ThingModel) {
                useObjectByThing(ThingModel(user));
            }
            if (isUsableByPlayer() && user is PlayerModel) {
                useObjectByPlayer(PlayerModel(user));
            }
        }

        protected function useObjectByThing(thing: ThingModel):void
        {

        }

        protected function useObjectByPlayer(player: PlayerModel):void
        {

        }

        public function isUsableByThing(): Boolean {
            return false;
        }

        public function isUsableByPlayer(): Boolean {
            return false;
        }

    }
}