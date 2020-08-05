package
{
    import model.LevelModel;
    import model.RoomModel;
    import model.PlayerModel;
    import model.ThingModel;
    import view.LevelView;
    import flash.display.MovieClip;
    import flash.events.Event;
    import view.PlayerView;
    import view.RoomView;
    import flash.events.MouseEvent;
    import characters.Interactable;

    public class LevelController {

        private var levelModel: LevelModel;
        private var levelView: LevelView;
        private var playerViews: Array = [];
        private var cameraLayer: MovieClip;
        private var selectedInteractable: Interactable;

        public function createLevel(levelModel: LevelModel, levelView: LevelView, cameraLayer: MovieClip): void {
            this.levelModel = levelModel;
            this.levelView = levelView;
            this.levelView.addEventListener(Event.ADDED_TO_STAGE, onLevelViewAddedToStage);
            this.cameraLayer = cameraLayer;
            
            initializeCharacters();

            this.cameraLayer.addChild(this.levelView);
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

        private function initializeCharacterViews(): void {
            for (var i: int = 0; i < levelModel.numMaxPlayers; i++) {

                var playerView: PlayerView = new PlayerView();
                    
                playerView.addEventListener(MouseEvent.MOUSE_OVER, interactOnMouseOver);
                playerView.addEventListener(MouseEvent.MOUSE_OUT, interactOnMouseOut);
                
                playerView.addEventListener(MouseEvent.CLICK, interactOnMouseClick);
                playerView.addEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);

                playerViews.push(playerView);
            }
        }

        protected function interactOnMouseOver(e:MouseEvent): void {}
		protected function interactOnMouseOut(e:MouseEvent): void {}
		
		protected function interactOnMouseClick(e:MouseEvent): void {
            if (selectedInteractable != null) {
                selectedInteractable.highlightForInteraction();
            }
            selectedInteractable = Interactable(e.target);
            selectedInteractable.unhighlightForInteraction();
        }
		protected function interactOnMouseRightClick(e:MouseEvent): void {}



        private function onLevelViewAddedToStage(e:Event): void {
            
            for(var i:int = 0; i < levelModel.numRooms; i++)
            {
                var roomModel: RoomModel = levelModel.rooms[i];

                for each(var playerModel:PlayerModel in roomModel.Players)
                {
                    var roomView: RoomView = levelView.rooms[i];
                    

                    var destination: Array = roomView.computePositionInRoom(playerViews.x, playerView.y, playerView.width, playerView.height);

			        playerView.x = destination[0], 
                    playerView.y = destination[1];

                    cameraLayer.addChild(playerView);

                    
                }
            }
        }
    }
}