package
{
    import model.LevelModel;
    import model.RoomModel;
    import model.PlayerModel;
    import model.ThingModel;
    import view.LevelView;
    import flash.display.MovieClip;
    import flash.events.Event;

    public class LevelController {

        private var levelModel: LevelModel;
        private var levelView: LevelView;

        public function createLevel(levelModel: LevelModel, levelView: LevelView, cameraLayer: MovieClip): void {
            this.levelModel = levelModel;
            this.levelView = levelView;
            this.levelView.addEventListener(Event.ADDED_TO_STAGE, onLevelViewAddedToStage);

            initializeCharacters();

            cameraLayer.addChild(this.levelView);
        }

        private function initializeCharacters(): void {
            var initialRoom: int = Math.round(Math.random() * (levelModel.numRooms - 1));

            for (var i: int = 0; i < levelModel.numMaxPlayers; i++) {
                var playerModel: PlayerModel = new PlayerModel();

                levelModel.putCharInRoom(playerModel, initialRoom);
            }

            var thingsInitialRoom: int = Math.round(Math.random() * (levelModel.numRooms - 1));
            if (thingsInitialRoom == initialRoom) {
                thingsInitialRoom = (thingsInitialRoom + 1) % levelModel.numRooms;
            }

            var thingModel: ThingModel = new ThingModel();

            levelModel.putCharInRoom(thingModel, thingsInitialRoom);
        }

        private function onLevelViewAddedToStage(e:Event): void {
            //start game logic
        }
    }
}