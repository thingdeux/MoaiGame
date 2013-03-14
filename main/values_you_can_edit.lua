module(..., package.seeall);

--Set Screen Size
resolutionWidth = 1024
resolutionHeight = 768
--Name of SpriteSheet
tilesheetlocation = "smurf_sprite.png"

--How many images are on each column of the tilesheet
tilesheet_rows_across = 4

--How many columns exist in the tilesheet
tilesheet_columns = 4



--Set how many frames are in the run animation
animation_keyframes = 17
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

idle_curvekeys = {
  { 1, 0.00, 4, 'MOAIEaseType.FLAT' },
  { 2, 1.00, 5, 'MOAIEaseType.FLAT' },
  { 3, 2.00, 6, 'MOAIEaseType.FLAT' },

}








--[[




module(..., package.seeall);

--Set Screen Size
resolutionWidth = 1024
resolutionHeight = 768
--Name of SpriteSheet
tilesheetlocation = "Character.png"

--How many images are on each column of the tilesheet
tilesheet_rows_across = 5

--How many columns exist in the tilesheet
tilesheet_columns = 2



--Set how many frames are in the run animation
animation_keyframes = 11


--Set the animation order and time between frames
--Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)
curvekeys = {
          { 1, 0.00, 1, 'MOAIEaseType.FLAT' },
          { 2, 0.05, 2, 'MOAIEaseType.FLAT' },
          { 3, 0.10, 3, 'MOAIEaseType.FLAT' },
          { 4, 0.15, 4, 'MOAIEaseType.FLAT' },
          { 5, 0.20, 5, 'MOAIEaseType.FLAT' },
          { 6, 0.25, 6, 'MOAIEaseType.FLAT' },
          { 7, 0.30, 7, 'MOAIEaseType.FLAT' },
          { 8, 0.35, 8, 'MOAIEaseType.FLAT' },
          { 9, 0.40, 9, 'MOAIEaseType.FLAT' },
          { 10, 0.45, 10, 'MOAIEaseType.FLAT' },
          { 11, 0.50, 1, 'MOAIEaseType.FLAT' },
      }]]