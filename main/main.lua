--Import config file settings
require "values_you_can_edit"
values = values_you_can_edit

--Various global Variables
player1 = {}
player2 = {}
chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.!1234567890/*-+()&^%$#@!~`{}[]":;?><,'

function set_player_vars(player)
  player.x = -510
  player.y = 0
  player.speed = 2
  
  player.move = {
    left = false,
    right = false
  }

  player.jump = false
  player.onGround = true
end

set_player_vars(player1)


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
	debugtext:setRect(-320, -440, 0, 0)
	debugtext:setAlignment(MOAITextBox.LEFT_JUSTIFY,MOAITextBox.BOTTOM_JUSTIFY)
  debugtext:moveLoc(-180, 370)
	
	prop = MOAIProp2D.new()		
	prop:setDeck (tileSheet)	
	prop:setLoc(player1.x,player1.y)

	curve = MOAIAnimCurve.new()
	

  --Set number of keyframes in the animation
  curve:reserveKeys ( values.animation_keyframes )

  function set_keys(animobj)
  for keys, values in pairs(values.curvekeys) do
      local builder = {}
    for key,value in pairs(values) do
        builder[#builder + 1] = value
    end
  animobj:setKey(builder[1], builder[2], builder[3], builder[4])
  end
end
 
  set_keys(curve)

  anim = MOAIAnim:new ()
  anim:reserveLinks ( 1 )
  anim:setLink ( 1, curve, prop, MOAIProp2D.ATTR_INDEX )
  anim:setMode ( MOAITimer.LOOP )
  
  layer:insertProp( debugtext )
  layer:insertProp ( prop )

  

end									   

---Function to handle debug information


function debug(debugvalues, numberofvalues)
  local builder = ''
  for i=1,numberofvalues do
    builder = builder .. " " .. tostring(debugvalues[i])
  end

   debugtext:setString(builder)
end



function playerControl(key, down)
  if key == 100 then
    player1.move.right = down
  elseif key == 97 then
    player1.move.left = down
  end

  if key == 119 and down and player1.onground then
    player1.jump = true
  end
end

playerThread = MOAIThread.new()
playerThread:run ( function()
    
    while true do

      if player1.onGround then
          
        if player1.move.right and not player1.move.left then
          anim:start()
          player1.x = player1.x + 20
        elseif player1.move.left and not player1.move.right then
          anim:start()
          player1.x = player1.x - 20
        else
          player1.x = player1.x
        end
      end 

      prop:setLoc(player1.x,player1.y)
      coroutine.yield()
    end 
end )



---Controller handler
if (MOAIInputMgr.device.keyboard) then
	MOAIInputMgr.device.keyboard:setCallback(
		function(key,down)
			if down then
        playerControl(key,down)
				
        --player1.move.right = true
        
			else
				anim:stop()
        player1.move.right = false
        player1.move.left = false
			end
		end
	)
end

debugThread = MOAIThread.new()
debugThread:run( function()
    while true do
      debug( {"Player1 Location: ", "X:",player1.x, "Y:", player1.y, "Right:", player1.move.right, "Left:",player1.move.left}, 9 )
      coroutine.yield() 
    end
      
end )


initViewport()
initGraphics(layer)