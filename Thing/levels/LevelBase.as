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

		protected var thingKillingProbability: Number = 3;
		protected var thingOpenAssimilationProbability: Number = 2;
		protected var humanKillingProbability: Number = 2;
		protected var thingCautiousnessLevel: Number = 1;

		public var onGameOver: Function;

		var camera: VirtualCamera;
		var cameraLayer: MovieClip;

		public function setCameraAndLayer(camera: VirtualCamera, cameraLayer: MovieClip): void {
			this.camera = camera;
			this.cameraLayer = cameraLayer;
		}

		public function reallocateRoomTilesToLayers(cameraLayer1: MovieClip, cameraLayer2: MovieClip): void {
			for each(var room:RoomBase in Rooms)
			{
				AsciiRoomBase(room).allocateChildrenToLayers(room, cameraLayer1, cameraLayer2);
				// return
			}
		}

		protected function get Rooms(): Array {
			throw new Error("Rooms not implemented");
		}


		protected function get Players() {
			var players = [];

			for each (var room: * in Rooms) {
				for each (var player: * in room.Players) {
					players.push(player);
				}
			}
			return players;
		}

		protected function get Things() {
			var things = []
			for each (var room: * in Rooms) {
				for each (var thing: * in room.Things) {
					things.push(thing);
				}
			}
			return things;
		}

		public function LevelBase() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		// may be overriden and called from subclass
		protected function onAddedToStage(e: Event): void {
			addEventListener(GlobalState.LIGHT_SWITCHED, function (e: * ): void {
				refreshThingsVisibility();
			});
						
			initializeRooms();
			initializePlayers();
			initializeThing();

			selectActiveCharacter();
		}

		public function refreshThingsVisibility(): void {
			for each (var thing: * in Things) {
				trace("lightSwitched");
				thing.refreshVisibility();
			}
		}

		//todo: make look nicer
		protected function initializeRooms() {
			for (var i: int = 0; i < Rooms.length; i++) {
				for (var j: int = 0; j < playerReachabilityMap[i].length; j++) {
					if (playerReachabilityMap[i][j] == 1) {
						Rooms[i].accessibleRooms.push(Rooms[j]);
					}

					if (thingReachabilityMap[i][j] == 1) {
						Rooms[i].adjacentRooms.push(Rooms[j]);
					}
				}
			}
		}

		protected function initializePlayers() {
			trace("Where do humans start?")
			var initialRoom = Utils.getRandom(Rooms.length, 1) - 1;

			for (var i: int = 0; i < maxPlayers; i++) {
				var player = new AsciiPlayer(humanInfectedRefusalProbability, 
					function () {
						return new AsciiThing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability)
					});
				player.setCameraAndLayer(this.camera, this.cameraLayer);
				//player.revelationCallback = function(myplayer:Player, isInfected:Boolean){paranoia.considerEvidence(myplayer, isInfected)};

				Rooms[initialRoom].register(player);
				cameraLayer.addChild(player);
			}
		}

		protected function initializeThing() {
			var thing = new AsciiThing(thingKillingProbability, thingOpenAssimilationProbability, thingCautiousnessLevel, humanKillingProbability);

			//todo: needs refactoring
			trace("Where does", thing, "start?");
			var thingsInitialRoom = Utils.getRandom(Rooms.length, 1) - 1;

			while (!Rooms[thingsInitialRoom].IsTakenOver) {
				trace(thing, "needs another room to start?");
				thingsInitialRoom = Utils.getRandom(Rooms.length - 1, 0, thingsInitialRoom);
			}

			Rooms[thingsInitialRoom].register(thing);
			cameraLayer.addChild(thing);
		}

		public function selectActiveCharacter() {
			var i = 0;
			if (GlobalState.draggableCharacter != null) {
				i = Players.indexOf(GlobalState.draggableCharacter)
			}
			
			Players[(i + 1) % Players.length].selectAsActiveCharacter();
			camera.pinCameraToObject(GlobalState.draggableCharacter, 0, 0);
			Players[i].unselectAsActiveCharacter();
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

			if (Rooms.every(function (item: * ) {
				return item.NonInfectedPlayers.length == 0
			})) {
				trace("HUMANS LOST");
				//stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPress);
				onGameOver();
			}

			if (Rooms.every(function (item: * ) {
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