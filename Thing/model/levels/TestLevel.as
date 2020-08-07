package model.levels
{
    import model.LevelModel;
    import model.RoomModel;
    import model.usables.SyringeDispenserModel;
    import model.usables.GeneratorModel;
    import model.usables.ExplosiveChargeDispenserModel;

    public class TestLevel extends LevelModel {
        public function TestLevel()
        {

            maxPlayers = 2;

            rooms = [
                new RoomModel([new SyringeDispenserModel()]), 
                new RoomModel([new GeneratorModel()]), 
                new RoomModel([]), 
                new RoomModel([new ExplosiveChargeDispenserModel()])
            ];

            playerReachabilityMap = 
			[
				[1, 1, 1, 0],
				[1, 1, 0, 1],
			    [1, 0, 1, 1],
				[0, 1, 1, 1]
			];
			
			thingReachabilityMap = 
			[
				[1, 1, 1, 0],
				[1, 1, 0, 1],
			    [1, 0, 1, 1],
				[0, 1, 1, 1]
			];   
        }

        
    }
}