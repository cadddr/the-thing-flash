package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import Character;

	public class Room extends MovieClip
	{
		public var characters:Array = [];
	
		protected function get IsReachable():Boolean
		{
			return GlobalState.draggableCharacter 
				&& GlobalState.draggableCharacter.ReachableRooms.indexOf(this) > -1;
		}
		
		public function get IsTakenOver():Boolean
		{
			var things = characters.filter(function(item:*) {return item is Thing});
			var players = characters.filter(function(item:*){return item is Player && (!item.IsInfected)});
			var infectedPlayers = characters.filter(function(item:*){return item is Player && item.IsInfected});

			return things.length + infectedPlayers.length >= players.length;
		}

		//tells how much the things are outnumbered by non-things
		public function get PlayerMargin():int
		{
			var things = characters.filter(function(item:*) {return item is Thing});
			var players = characters.filter(function(item:*){return item is Player && (!item.IsInfected)});
			var infectedPlayers = characters.filter(function(item:*){return item is Player && item.IsInfected});

			return players.length - things.length - infectedPlayers.length;
		}
		
		public function get Players()
		{
			return characters.filter(function(item:*){return item is Player && (!item.IsInfected)});
		}

		public function Room()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		protected function onAddedToStage(e:Event)
		{
			//highlighting
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);

			//for putting draggable players into rooms
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
		}

		private function onMouseOver(e:MouseEvent)
		{
			if (!GlobalState.draggableCharacter || IsReachable)
			{
				highlightSelected();
			}
			else
			{
				highlightRestricted();
			}
		}

		private function onMouseOut(e:MouseEvent)
		{
			if (IsReachable)
			{
				highlightReachable();
			}
			else
			{
				unhighlight();
			}
		}

		//undrags the player and puts it into the room
		private function onMouseUp(event : MouseEvent)
		{
			if (IsReachable)
			{
				var draggableCharacter = GlobalState.draggableCharacter;

				if (draggableCharacter != null)
				{
					putIn(draggableCharacter);
					draggableCharacter.finalizeAction();
				}
			}
		}

		public function unhighlight()
		{
			gotoAndStop(1);
		}

		public function highlightSelected()
		{
			gotoAndStop(2);
		}

		public function highlightReachable()
		{
			gotoAndStop(3);
		}

		public function highlightRestricted()
		{
			gotoAndStop(4);
		}


		public function putIn(character:Character)
		{
			//leave previous room
			character.leaveRoom();

			characters.push(character);
			character.currentRoom = this;

			GlobalState.things.forEach(function(item:*){item.refreshVisibility()});
			
			positionInRoom(character, this);
		}

		// puts a character at a random location within a specified room
		protected function positionInRoom(whom:Character, where:Room)
		{
			var offset_x = Math.pow(-1,Math.round(Math.random() + 1)) * Math.random() * where.width / 2;
			var correction_x = offset_x < 0 ? whom.width / 2: -  whom.width / 2;
			whom.x = where.x + offset_x + correction_x;

			var offset_y = Math.pow(-1,Math.round(Math.random() + 1)) * Math.random() * where.height / 2;
			var correction_y = offset_y < 0 ? whom.height / 2: -  whom.height / 2;
			whom.y = where.y + offset_y + correction_y;
		}		
	}
}