--Import config file settings
values = require "values_you_can_edit"
players = require "players"
level = require "level"

--Various global Variables
player1 = {}

chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.!1234567890/*-+()&^%$#@!~`{}[]":;?><,'

players.set_player_vars(player1)

--Initialize the viewport and create a layer
function initViewport()
  camera = MOAICamera2D.new()
  screenWidth = MOAIEnvironment.screenWidth
  screenHeight = MOAIEnvironment.screenHeight 
  if screenWidth == nil then screenWidth = values.resolutionWidth end
  if screenHeight == nil then screenHeight = values.resolutionHeight end

  MOAISim.openWindow("Window", screenWidth, screenHeight)

  viewport = MOAIViewport.new()
  viewport:setSize(screenWidth,screenHeight)    
  viewport:setScale(1280,1024)


  layer = MOAILayer2D.new() 
  layer:setViewport(viewport)
  layer:setCamera( camera )


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
  debugtext:setRect(-320, -440, 640, 0)
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

  function set_animation_keys(animobj,keyloc)
  for keys, values in pairs(keyloc) do
      local builder = {}
    for key,value in pairs(values) do
        builder[#builder + 1] = value
        print ("Rolled for: " .. tostring(value) )
    end
  animobj:setKey(builder[1], builder[2], builder[3], builder[4])
  end
end
 
  set_animation_keys(curve,values.curvekeys)
  --set_animation_keys(idlecurve,values.idle_curvekeys)

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
  level.loadLevel()
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

--Create a player thread and monitor for keyboard input then perform actions.
playerThread = MOAIThread.new()
playerThread:run ( function()
    
    while true do

      if player1.onGround then
          
        if player1.move.right and not player1.move.left then
          player1.isIdle = false
          anim:start()

          --If the player gets to the edge of the screen going right, place him on the left edge
            if player1.x > values.resolutionWidth / 2 then
              player1.x = -values.resolutionWidth /2 - values.playerScaleX
            end
          
        elseif player1.move.left and not player1.move.right then
          player1.isIdle = false
          anim:start()

          --If the player gets to the edge of the screen going left, place him on the right edge
            if player1.x < -values.resolutionWidth / 2 then
              player1.x = values.resolutionWidth / 2 + values.playerScaleX / 2
            end

        elseif not player1.move.left and not player1.move.right and player1.speed <= 0 then
          player1.isIdle = true
          player1.speed = 0
        elseif player1.speed < 0 then player1.isIdle = true
      
        end

      end 

      players.calculateGravity(player1)
      players.calculateSpeed(player1)
      prop:setLoc(player1.x,player1.y)
      coroutine.yield()
    end 
end )


---Keyboard controller handler
if (MOAIInputMgr.device.keyboard) then
  MOAIInputMgr.device.keyboard:setCallback(
    function(key,down)
      if down then
        players.playercontrol(key,down)
     
      else

        players.playercontrol(key,down)
        
      end
    end
  )
end


--Initialize Debug Thread
debugThread = MOAIThread.new()
debugThread:run( function()
    while true do
      debug( {"Speed: ", player1.speed, "Idle: ", player1.isIdle})
      coroutine.yield()
    end
      
end )


--Initialize the graphics and the viewport
initViewport()
initGraphics(layer)


