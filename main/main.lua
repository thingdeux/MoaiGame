--Import config file settings
require "values_you_can_edit"
values = values_you_can_edit

--Various global Variables
player1 = {-500, -400, 1, false}
player2 = {0, 0, 2}
chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.!1234567890/*-+()&^%$#@!~`{}[]":;?><,'

--Initialize the viewport and create a layer
function initViewport()
  screenWidth = MOAIEnvironment.screenWidth
  screenHeight = MOAIEnvironment.screenHeight	
  if screenWidth == nil then screenWidth = values.resolutionWidth end
  if screenHeight == nil then screenHeight = values.resolutionHeight end

  MOAISim.openWindow("Window", screenWidth,	screenHeight)

  viewport = MOAIViewport.new()
  viewport:setSize(screenWidth,screenHeight)		
  viewport:setScale(screenWidth,screenHeight)		

  layer = MOAILayer2D.new()	
  layer:setViewport(viewport)
  MOAIRenderMgr.pushRenderPass(layer)
end



------Initialize the graphics
function initGraphics()
  
	tileSheet = MOAITileDeck2D.new ()
	--Place the sprite sheet in the same folder and enter its name here
	tileSheet:setTexture (values.tilesheetlocation)
	--Set the number of rows horizontally and vertically that exist in the sheet
	tileSheet:setSize (values.tilesheet_rows_across, values.tilesheet_columns)
	--Determine size of the image on the screen
	tileSheet:setRect( 0, 0, 300, 300)
	

	font = MOAIFont.new()
	font:loadFromTTF('arial-rounded.TTF',chars,7.15,163)

	debugtext = MOAITextBox.new()
	debugtext:setFont(font)
	debugtext:setTextSize(7.15,163)
	debugtext:setYFlip(true)
	debugtext:setRect(320, 240, 0, 0)
	debugtext:setAlignment(MOAITextBox.LEFT_JUSTIFY,MOAITextBox.TOP_JUSTIFY)
	
	prop = MOAIProp2D.new()		
	prop:setDeck (tileSheet)	
	prop:setLoc(-500,-400)		

	curve = MOAIAnimCurve.new()
	

  --Set number of keyframes in the animation
  curve:reserveKeys ( values.animation_keyframes )

  --Set the order and time between frames
  --Structure (Order # In Animation, Time Delay, Frame to Pull on the Sheet, MOAItransitionStyle)
  curve:setKey ( 1, 0.00, 1, MOAIEaseType.FLAT )
  curve:setKey ( 2, 0.05, 2, MOAIEaseType.FLAT )
  curve:setKey ( 3, 0.10, 3, MOAIEaseType.FLAT )
  curve:setKey ( 4, 0.15, 4, MOAIEaseType.FLAT )
  curve:setKey ( 5, 0.20, 5, MOAIEaseType.FLAT )
  curve:setKey ( 6, 0.25, 6, MOAIEaseType.FLAT )
  curve:setKey ( 7, 0.30, 7, MOAIEaseType.FLAT )
  curve:setKey ( 8, 0.35, 8, MOAIEaseType.FLAT )
  curve:setKey ( 9, 0.40, 9, MOAIEaseType.FLAT )
  curve:setKey ( 10, 0.45, 10, MOAIEaseType.FLAT )
  curve:setKey ( 11, 0.50, 1, MOAIEaseType.FLAT )

  anim = MOAIAnim:new ()
	anim:reserveLinks ( 1 )
	anim:setLink ( 1, curve, prop, MOAIProp2D.ATTR_INDEX )
	anim:setMode ( MOAITimer.LOOP )
  
  layer:insertProp( debugtext )
  layer:insertProp ( prop )

	end									   



  

if (MOAIInputMgr.device.keyboard) then
	MOAIInputMgr.device.keyboard:setCallback(
		function(key,down)
			if down == true then
				anim:start()
			else
				anim:stop()
			end
		end
	)
end

initViewport()
initGraphics(layer)

