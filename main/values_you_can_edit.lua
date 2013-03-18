module(..., package.seeall);

--Set Screen/Resolution Size
resolutionWidth = 1024
resolutionHeight = 768

--Player Size Control (Smaller numbers = smaller character)
playerScaleX = 185
playerScaleY = 295

--Player's Max Velocity --Determines how fast they can walk/run
playerSpeed = .8
playerForceUpwards = 60

--World Variables
windResistance = .25
gravity = 2

--Name of SpriteSheet (to be placed in the same directory)
tilesheetlocation = "AgileWalkSpriteSheettest2.png"
backgroundtilesheetlocation = ""

--How many images are on each row of the main tilesheet
tilesheet_rows_across = 4
--How many columns exist in the main tilesheet
tilesheet_columns = 3
--Set how many frames are in the main run animation
animation_keyframes = 7
--Set how many frames are in the idle animation
idle_animation_keyframes = 1		


--Set the animation order and time between frames
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)
curvekeys = {
				  { 1, 0.00, 1, 'MOAIEaseType.FLAT' },
				  { 2, 0.50, 3, 'MOAIEaseType.FLAT' },
  				{ 3, 1.0, 5, 'MOAIEaseType.FLAT' },
  				{ 4, 1.50, 7, 'MOAIEaseType.FLAT' },
  				{ 5, 2.0, 10, 'MOAIEaseType.FLAT' },
  				{ 6, 2.50, 11, 'MOAIEaseType.FLAT' },
			{ 7, 2.55, 1, 'MOAIEaseType.FLAT' },
  				

			}

--Set the animation order and time between frames on the idle animation
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)

idle_curvekeys = {
  { 1, 0.00, 1, 'MOAIEaseType.FLAT' },
  --{ 2, 1.00, 5, 'MOAIEaseType.FLAT' },
--{ 3, 2.00, 6, 'MOAIEaseType.FLAT' },

}