package 
{
	import flash.display.MovieClip;
	import flash.events.*;
	import GlobalState;
	import Character;

	public class Room extends MovieClip
	{
		protected var guests:Array = [];
		
		public var accessibleRooms:Array = [];
		public var adjacentRooms:Array = [];
		
		protected var isReachable:Boolean = false;
		
		public function get IsReachable():Boolean
		{
			return isReachable;
		}
		
		public function set IsReachable(value:Boolean)
		{
			isReachable = value;
			
			if(value)
			{
				highlightReachable();
			}
			else
			{
				unhighlight();
			}
		}
		
		public function get Things():Array
		{
			return guests.filter(function(item:*) {return item is Thing});
		}
		
		public function get Players():Array
		{
			return guests.filter(function(item:*) {return item is Player});
		}
		
		public function get InfectedPlayers():Array
		{
			return Players.filter(function(item:*) {return item.IsInfected});
		}

		public function get NonInfectedPlayers()
		{
			return Players.filter(function(item:*){return !item.IsInfected});
		}
		
		//tells how much the things are outnumbered by non-things
		public function get NonInfectedPlayerMargin():int
		{			
			return NonInfectedPlayers.length - Things.length - InfectedPlayers.length;
		}
		
		public function getRoommates(player:Player)
		{
			return Players.filter(function(item:*){return item != player});
		}
		
		public function get IsTakenOver():Boolean
		{
			return NonInfectedPlayerMargin <= 0;
		}
		
		public function get VisibleThings()
		{
			return Things.filter(function(item:*) {return item.isVisible});
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
				
				highlightReachableRooms(false);
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

		public function highlightReachableRooms(shouldHighlight:Boolean) 
		{			
			accessibleRooms.forEach(function(room:*) 
									{
										room.IsReachable = shouldHighlight;
										
									});
		}

		public function putIn(character:Character)
		{
			//leave previous room
			character.leaveRoom();

			guests.push(character);
			character.currentRoom = this;

			Things.forEach(function(thing:*){thing.refreshVisibility()});
			
			positionInRoom(character, this);
		}
		
		public function getOut(character:Character)
		{
			var characterIndex = guests.indexOf(character);
			guests.splice(characterIndex, 1);
			
			Things.forEach(function(thing:*){thing.refreshVisibility()});
		}
		
		public function killGuests()
		{
			//cloning to avoid mutability problems
			var tempChars = guests.concat();
			tempChars.forEach(function(item:*) {item.die()});
		}
		
		public function revealInfectedPlayers()
		{
			guests.forEach(function(item:*) {if (item is Player) item.revealItself()});
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