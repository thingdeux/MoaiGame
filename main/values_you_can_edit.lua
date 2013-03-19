module(..., package.seeall);

--Set Screen/Resolution Size
resolutionWidth = 1024
resolutionHeight = 768

--Player Size Control (Smaller numbers = smaller character)
playerScaleX = 185
playerScaleY = 295

--Player's Max Velocity --Determines how fast they can walk/run
playerSpeed = 4
playerForceUpwards = 60

--World Variables
windResistance = 1
gravity = 2

--Name of SpriteSheet (to be placed in the same directory)
tilesheetlocation = "AgileWalkSpriteSheettest2.png"
backgroundtilesheetlocation = "MapTiles.png"

--How many images are on each row of the main tilesheet
tilesheet_rows_across = 4
--How many columns exist in the main tilesheet
tilesheet_columns = 3
--Set how many frames are in the main run animation
animation_keyframes = 11
--Set how many frames are in the idle animation
idle_animation_keyframes = 1		


--Set the animation order and time between frames
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)

--[[
curvekeys = {
				  { 1, 0.10, 1, 'MOAIEaseType.FLAT' },
				  { 2, 0.20, 3, 'MOAIEaseType.FLAT' },
  				{ 3, 0.30, 5, 'MOAIEaseType.FLAT' },
  				{ 4, 0.40, 7, 'MOAIEaseType.FLAT' },
  				{ 5, 0.50, 10, 'MOAIEaseType.FLAT' },
  				{ 6, 0.60, 11, 'MOAIEaseType.FLAT' },
			    --{ 7, 0.62, 1, 'MOAIEaseType.FLAT' },
  				

			}--]]
      


curvekeys = {
          { 1, 0.0, 1, 'MOAIEaseType.EASE_IN' },
          { 2, 0.10, 2, 'MOAIEaseType.SMOOTH' },
          { 3, 0.20, 3, 'MOAIEaseType.SMOOTH' },
          { 4, 0.30, 4, 'MOAIEaseType.SMOOTH' },
          { 5, 0.40, 5, 'MOAIEaseType.SMOOTH' },
          { 6, 0.50, 6, 'MOAIEaseType.SMOOTH' },
          { 7, 0.60, 7, 'MOAIEaseType.SMOOTH' },
          { 8, 0.70, 8, 'MOAIEaseType.SMOOTH' },
          { 9, 0.80, 9, 'MOAIEaseType.SMOOTH' },
          { 10, 0.90, 10, 'MOAIEaseType.SMOOTH' },
          { 11, 1.0, 11, 'MOAIEaseType.EASE_OUT' }      

      }



--Set the animation order and time between frames on the idle animation
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)

idle_curvekeys = {
  --{ 1, 0.00, 1, 'MOAIEaseType.FLAT' },
  --{ 2, 1.00, 5, 'MOAIEaseType.FLAT' },
--{ 3, 2.00, 6, 'MOAIEaseType.FLAT' },

}