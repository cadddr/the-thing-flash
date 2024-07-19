package levels {

	import flash.display.MovieClip;
	import flash.events.*;
	import flash.display.SimpleButton;
	import Utils;
	import characters.*;
	import rooms.GeneratorRoomInterface;
	import fl.VirtualCamera;
	import flash.html.__HTMLScriptArray;
	import asciiRooms.AsciiRoomBase;
	import flash.utils.describeType;
	import rooms.RoomBase;


	public class LevelBase extends MovieClip {
		protected var maxPlayers = 5;

		protected var playerReachabilityMap: Array;
 		protected var thingReachabilityMap: Array;

		//out of 6
		protected var leftBehindProbability: Number = 2
		protected var humanInfectedRefusalProbability = 2;

		public var onGameOver: Function;

		var camera: VirtualCamera;
		var cameraLayer: MovieClip;

		public function setCameraAndLayer(camera: VirtualCamera, cameraLayer: MovieClip): void {
			this.camera = camera;
			this.cameraLayer = cameraLayer;
		}

		public function reallocateRoomTilesToLayers(cameraLayer1: MovieClip, cameraLayer2: MovieClip): void {
			for each(var room:RoomBase in GlobalState.rooms)
			{
				AsciiRoomBase(room).allocateChildrenToLayers(room, cameraLayer1, cameraLayer2);
				// return
			}
		}


		protected function get Players() {
			var players = [];

			GlobalState.rooms.forEach(function (room: * ) {
				room.Players.forEach(function (player: * ) {
					players.push(player);
				});
			});
			return players;
		}

		protected function get Things() {
			var things = []
			GlobalState.rooms.forEach(function (room: * ) {
				room.Things.forEach(function (thing: * ) {
					things.push(thing);
				});
			});
			return things;
		}

		public function LevelBase() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		// may be overriden and called from subclass
		protected function onAddedToStage(e: Event): void {
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);

			addEventListener(GlobalState.LIGHT_SWITCHED, function (e: * ): void {
				refreshThingsVisibility();
			});
						
			initializeRooms(GlobalState.rooms);
			initializePlayers();
			initializeThing();

			selectActiveCharacter();
		}

		private static const KEY_SPACE: int = 32;
		private static const KEY_D: int = 68;
		private static const KEY_TAB: int = 9;

		protected function onKeyPress(e: KeyboardEvent): void {
			switch (e.keyCode) {
				case KEY_SPACE:
					endTurn();
					break;
				case KEY_D:
					toggleDebugMode();
					break;
				case KEY_TAB:
					selectActiveCharacter();
					break;
				default:
					// No action for other keys
					break;
			}
		}

		private function toggleDebugMode(): void {
			trace("Debug mode", GlobalState.DEBUG);
			GlobalState.DEBUG = !GlobalState.DEBUG;
			refreshThingsVisibility();
		}

		private function refreshThingsVisibility(): void {
			Things.forEach(function (thing: * ): void {
				trace("lightSwitched");
				thing.refreshVisibility();
			});
		}

		protected function selectActiveCharacter() {
			var i = 0;
			if (GlobalState.draggableCharacter != null) {
				i = Players.indexOf(GlobalState.draggableCharacter)
			}
			
			Players[(i + 1) % Players.length].selectAsActiveCharacter();
			camera.pinCameraToObject(GlobalState.draggableCharacter, 0, 0);
			Players[i].unselectAsActiveCharacter();
		}

		//todo: make look nicer
		protected function initializeRooms(shrooms: Array) {
			for (var i: int = 0; i < shrooms.length; i++) {
				for (var j: int = 0; j < playerReachabilityMap[i].length; j++) {
					if (playerReachabilityMap[i][j] == 1) {
						shrooms[i].accessibleRooms.push(shrooms[j]);
					}

					if (thingReachabilityMap[i][j] == 1) {
						shrooms[i].adjacentRooms.push(shrooms[j]);
					}
				}
			}
		}

		protected function initializePlayers() {
			trace("Where do humans start?")
			var initialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;

			for (var i: int = 0; i < maxPlayers; i++) {
				var player = new AsciiPlayer(humanInfectedRefusalProbability);
				player.setCameraAndLayer(this.camera, this.cameraLayer);
				//player.revelationCallback = function(myplayer:Player, isInfected:Boolean){paranoia.considerEvidence(myplayer, isInfected)};

				GlobalState.rooms[initialRoom].register(player);
				cameraLayer.addChild(player);
			}
		}

		protected function initializeThing() {
			var thing = new AsciiThing();

			//todo: needs refactoring
			trace("Where does", thing, "start?");
			var thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length, 1) - 1;

			while (!GlobalState.rooms[thingsInitialRoom].IsTakenOver) {
				trace(thing, "needs another room to start?");
				thingsInitialRoom = Utils.getRandom(GlobalState.rooms.length - 1, 0, thingsInitialRoom);
			}

			GlobalState.rooms[thingsInitialRoom].register(thing);
			cameraLayer.addChild(thing);
		}

		protected function identifySquads() {
			var squads: Array = [];
			var checkedSquadMembers: Array = [];

			for (var i: int = 0; i < Players.length; i++) {
				//identifying squads of players moving together
				var checkSameSquad: Function = function (item: * ) {
					return item.previousRoom == Players[i].previousRoom && item.currentRoom == Players[i].currentRoom && item.currentRoom != Players[i].previousRoom && item.previousRoom != Players[i].currentRoom && item.IsInactive;
				}

				if (!checkedSquadMembers.some(checkSameSquad) && Players[i].IsInactive) {
					var squad: Array = Players.filter(checkSameSquad);

					squads.push(squad);
					//so we wouldn't consider members of the same squad twice
					checkedSquadMembers.push(Players[i]);
				}
			}
			return squads.filter(function (squad: * ) {
				return squad.length > 1
			});
		}

		//return random players to their previous rooms
		protected function returnRandomSquadMember(squad: * ) {
			trace("Squad: [", squad, "]");
			trace("Will someone get left behind?");
			if (Utils.getRandom(6, 1) <= leftBehindProbability) {
				trace("Who's the lucky man?");
				var luckyMan: Player = squad[Utils.getRandom(squad.length - 1)];
				luckyMan.previousRoom.register(luckyMan);
			}
		}
		
		public function endTurn() {
			var squads = identifySquads();
			squads.forEach(function (squad: * ) {
				returnRandomSquadMember(squad)
			});

			Players.forEach(function (item: * ) {
				item.act()
			});
			Things.forEach(function (item: * ) {
				item.act()
			});

			if (GlobalState.rooms.every(function (item: * ) {
				return item.NonInfectedPlayers.length == 0
			})) {
				trace("HUMANS LOST");
				//stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				onGameOver();

			}

			if (GlobalState.rooms.every(function (item: * ) {
				return item.Things.length == 0 && item.InfectedPlayers.length == 0
			})) {
				trace("HUMANS WON");
				//stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				onGameOver();
			}

			//reset action flags
			Players.forEach(function (item: * ) {
				item.IsInactive = false
			});

		}

	}

}