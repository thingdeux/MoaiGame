--Import config file settings
require "values_you_can_edit"
values = values_you_can_edit

--Various global Variables
player1 = {}
player2 = {}
chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.!1234567890/*-+()&^%$#@!~`{}[]":;?><,'

function set_player_vars(player)
  player.x = -510
  player.y = -512
  player.speed = 2
  
  player.move = {
    left = false,
    right = false
  }

  player.jump = false
  player.onGround = true
  player.isIdle = true
  player.facing = {
    right = true,
    left = false
   }

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
  viewport:setScale(1280,1024)		

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
	tileSheet:setRect( 0, 0, values.playerScaleX, values.playerScaleY)
	

	font = MOAIFont.new()
	font:loadFromTTF('arial-rounded.TTF',chars,7.15,163)

	debugtext = MOAITextBox.new()
	debugtext:setFont(font)
	debugtext:setTextSize(7.15,163)
	debugtext:setYFlip(true)
	debugtext:setRect(-320, -440, 0, 0)
	debugtext:setAlignment(MOAITextBox.LEFT_JUSTIFY,MOAITextBox.BOTTOM_JUSTIFY)
  debugtext:moveLoc(-320, 512)
	
	prop = MOAIProp2D.new()		
	prop:setDeck (tileSheet)	
	prop:setLoc(player1.x,player1.y)


	curve = MOAIAnimCurve.new()
  idlecurve = MOAIAnimCurve.new()
	

  --Set number of keyframes in the animation
  curve:reserveKeys ( values.animation_keyframes )
  idlecurve:reserveKeys (values.idle_animation_keyframes)

  function set_keys(animobj,keyloc)
  for keys, values in pairs(keyloc) do
      local builder = {}
    for key,value in pairs(values) do
        builder[#builder + 1] = value
    end
  animobj:setKey(builder[1], builder[2], builder[3], builder[4])
  end
end
 
  set_keys(curve,values.curvekeys)
  set_keys(idlecurve,values.idle_curvekeys)

  anim = MOAIAnim:new ()
  anim:reserveLinks ( 1 )
  anim:setLink ( 1, curve, prop, MOAIProp2D.ATTR_INDEX )
  anim:setMode ( MOAITimer.LOOP )
  anim:apply(4)

  idleanim = MOAIAnim:new()
  idleanim:reserveLinks (1)
  idleanim:setLink(1, idlecurve, prop, MOAIProp2D.ATTR_INDEX)
  idleanim:setMode ( MOAITimer.LOOP)
  idleanim:start()

  layer:insertProp( debugtext )
  layer:insertProp ( prop )

  

end									   

---Function to handle debug information


function debug(debugvalues)
  local numberofvalues = #debugvalues
  local builder = ''
  for i=1,numberofvalues do
    builder = builder .. " " .. tostring(debugvalues[i])
  end

   debugtext:setString(builder)
end

function playerTransition(player,key)
  if player.facing.left and key == 100 then
    player.facing.right = true
    player.facing.left = false
    tileSheet:setRect( 0, 0, values.playerScaleX, values.playerScaleY)
    player1.move.right = true
    player1.x = player1.x - values.playerScaleX
  elseif player.facing.right and key == 97 then
    player.facing.left = true
    player.facing.right = false
    tileSheet:setRect( 0, 0, -values.playerScaleX, values.playerScaleY)
    player1.move.left = true
    player1.x = player1.x + values.playerScaleX

  end

end



function playerControl(key, down)
--'D' key press for going right
  if key == 100 and down then
    if player1.facing.left then
      playerTransition(player1, key)
    else
      player1.move.right = down
    end
--'D' key released
  elseif key == 100 and not down and player1.onGround then
    anim:stop()
    idleanim:start()
    player1.isIdle = true
    player1.move.right = false

--'A' key press for going left
  elseif key == 97 and down then
    if player1.facing.right then

      playerTransition(player1, key)
    else
      player1.move.left = down
    end
--'A' key released
  elseif key == 97 and not down and player1.onGround then
    anim:stop()
    idleanim:start()
    player1.isIdle = true
    player1.move.left = false

  elseif key == 97 and key == 100 then
    player1.isIdle = true
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
          player1.isIdle = False
          anim:start()
          player1.x = player1.x + values.playerVelocity - values.windResistance
            if player1.x > values.resolutionWidth / 2 then
              player1.x = -values.resolutionWidth /2 - values.playerScaleX
            end
          
        elseif player1.move.left and not player1.move.right then
          player1.isIdle = False
          anim:start()
          player1.x = player1.x - values.playerVelocity + values.windResistance
            if player1.x < -values.resolutionWidth / 2 then
              player1.x = values.resolutionWidth / 2 + values.playerScaleX / 2
            end
        else
          player1.isIdle = True


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
      
			else

        playerControl(key,down)
        
			end
		end
	)
end


--Initialize Debug Thread
debugThread = MOAIThread.new()
debugThread:run( function()
    while true do
      debug( {"Player1 Location: ", "X:",player1.x, "Y:", 
        player1.y, "Right:", player1.move.right, "Left:",player1.move.left, "Resistance", values.windResistance})
      coroutine.yield() 
    end
      
end )


initViewport()
initGraphics(layer)