module(..., package.seeall);

--Set Screen/Resolution Size
resolutionWidth = 1280
resolutionHeight = 1024

--Player Size Control (Smaller numbers = smaller character)
playerScaleX = 250
playerScaleY = 250

--Player's Max Velocity --Determines how fast they can walk/run
playerSpeed = 8
playerForceUpwards = 40

--World Variables
windResistance = 1
gravity = 2

--Name of SpriteSheet (to be placed in the same directory)
tilesheetlocation = "smurf_sprite.png"

--How many images are on each row of the main tilesheet
tilesheet_rows_across = 4
--How many columns exist in the main tilesheet
tilesheet_columns = 4
--Set how many frames are in the main run animation
animation_keyframes = 17
--Set how many frames are in the idle animation
idle_animation_keyframes = 3			


--Set the animation order and time between frames
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)
curvekeys = {
				  { 1, 0.00, 4, 'MOAIEaseType.FLAT' },
				  { 2, 0.05, 5, 'MOAIEaseType.FLAT' },
  				{ 3, 0.10, 6, 'MOAIEaseType.FLAT' },
  				{ 4, 0.15, 7, 'MOAIEaseType.FLAT' },
  				{ 5, 0.20, 8, 'MOAIEaseType.FLAT' },
  				{ 6, 0.25, 9, 'MOAIEaseType.FLAT' },
  				{ 7, 0.30, 10, 'MOAIEaseType.FLAT' },
  				{ 8, 0.35, 11, 'MOAIEaseType.FLAT' },
  				{ 9, 0.40, 12, 'MOAIEaseType.FLAT' },
  				{ 10, 0.45, 13, 'MOAIEaseType.FLAT' },
  				{ 11, 0.50, 14, 'MOAIEaseType.FLAT' },
          { 12, 0.55, 15, 'MOAIEaseType.FLAT' },
          { 13, 0.60, 16, 'MOAIEaseType.FLAT' },
          { 14, 0.65, 1, 'MOAIEaseType.FLAT' },
          { 15, 0.70, 2, 'MOAIEaseType.FLAT' },
          { 16, 0.75, 3, 'MOAIEaseType.FLAT' },
          { 17, 0.80, 4, 'MOAIEaseType.FLAT' },
			}

--Set the animation order and time between frames on the idle animation
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)

idle_curvekeys = {
  { 1, 0.00, 4, 'MOAIEaseType.FLAT' },
  { 2, 1.00, 5, 'MOAIEaseType.FLAT' },
  { 3, 2.00, 6, 'MOAIEaseType.FLAT' },

}