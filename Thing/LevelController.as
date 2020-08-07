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
    import view.InteractableView;
    import fl.transitions.Tween;
	import fl.transitions.TweenEvent;
    import fl.transitions.easing.*;
    import flash.html.__HTMLScriptArray;

    public class LevelController {

        private var levelModel: LevelModel;
        private var levelView: LevelView;
        private var playerViews: Array = [];
        private var cameraLayer: MovieClip;
        private var selectedInteractable: InteractableView;

        public function createLevel(levelModel: LevelModel, levelView: LevelView, cameraLayer: MovieClip): void {
            this.levelModel = levelModel;
            this.levelView = levelView;
            this.levelView.addEventListener(Event.ADDED_TO_STAGE, onLevelViewAddedToStage);
            this.cameraLayer = cameraLayer;
            
            levelModel.initializeCharacterModels();
            initializeCharacterViews();
            initializeRoomViews();

            this.cameraLayer.addChild(this.levelView);
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

        private function initializeRoomViews(): void {
            for each(var roomView:RoomView in levelView.rooms)
            {
                roomView.addEventListener(MouseEvent.RIGHT_CLICK, interactOnMouseRightClick);   
            }
        }

        private function onLevelViewAddedToStage(e:Event): void {
            var currentPlayerIndex: int = 0;
            for(var i:int = 0; i < levelModel.numRooms; i++)
            {
                var roomModel: RoomModel = levelModel.rooms[i];

                for each(var playerModel:PlayerModel in roomModel.Players)
                {
                    var roomView: RoomView = levelView.rooms[i];
                    
                    var playerView: PlayerView = playerViews[currentPlayerIndex++];        
                              
                    var destination: Array = roomView.computePositionInRoom(playerView.x, 
                                                                            playerView.y, 
                                                                            playerView.width, 
                                                                            playerView.height);

			        playerView.x = destination[0], 
                    playerView.y = destination[1];

                    cameraLayer.addChild(playerView);
                }
            }
        }

        protected function interactOnMouseOver(e:MouseEvent): void {
            InteractableView(e.currentTarget).highlightForInteraction();
        }
		protected function interactOnMouseOut(e:MouseEvent): void {
            if (e.currentTarget != selectedInteractable) {
                InteractableView(e.currentTarget).unhighlightForInteraction();
            }
        }
		
		protected function interactOnMouseClick(e:MouseEvent): void {
            trace("left mouse", e.currentTarget);
            if (selectedInteractable != null) {
                selectedInteractable = null;
            }
            var interactionTarget: InteractableView = InteractableView(e.currentTarget);
            if (checkSelectable(interactionTarget)) {
                selectedInteractable = interactionTarget;   
            }
        }

        private function checkSelectable(interactable: InteractableView): Boolean {
            if (interactable is PlayerView) {
                var i: int = playerViews.indexOf(interactable);
                return levelModel.players[i].alreadyActed == 0;
            }

            return false;
        }

		protected function interactOnMouseRightClick(e:MouseEvent): void {
            trace("right mouse", e.currentTarget)
            if (selectedInteractable != null) {
                if (selectedInteractable is PlayerView) {
                    var interactionTarget: InteractableView = InteractableView(e.currentTarget);
                    if (interactionTarget is RoomView) {
                        var roomId: int = levelView.rooms.indexOf(interactionTarget);
                        var playerId: int = playerViews.indexOf(selectedInteractable); 
                        var result: Boolean = levelModel.moveCharToRoom(playerId, roomId);

                        if (result) {
                            movePlayerToRoom(playerViews[playerId], RoomView(interactionTarget), cameraLayer.mouseX, cameraLayer.mouseY);
                        }
                    }
                }
            }
        }

        private function movePlayerToRoom(playerView: PlayerView, roomView: RoomView, x: Number, y: Number):void
        {
            // if (camera != null) {
			// 	camera.pinCameraToObject(this);
			// }
			
			// gotoAndPlay(1);

			var tweenX: Tween = new Tween(this, "x", Strong.easeInOut, playerView.x, x, 24);
			var tweenY: Tween = new Tween(this, "y", Strong.easeInOut, playerView.y, y, 24);

			// tweenX.addEventListener(TweenEvent.MOTION_CHANGE, function(e:TweenEvent) {
			// 	AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, e.position, y);
			// })

			// tweenY.addEventListener(TweenEvent.MOTION_CHANGE, function(e:TweenEvent) {
			// 	AsciiRoomBase(currentRoom).applyTileLightingFromSource(currentRoom, x, e.position);
			// })

            var helper: Function = function (first: Tween, second: Tween): void {
                second.stop();
				first.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent): void {
					second.start()
				});
                // tweenY.addEventListener(TweenEvent.MOTION_FINISH, function(e:TweenEvent) {stop();})
            }

			if (Math.abs(x - playerView.x) > Math.abs(y - playerView.y)) {
				helper(tweenX, tweenY);
			}
			else {
				helper(tweenY, tweenX);
			}
            
        }
    }
}