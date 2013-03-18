module(..., package.seeall);

function set_player_vars(player)
  player.x = -510
  player.y = -512
  player.speed = 0
  player.jumpSpeed = 0
  
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

function playercontrol(key, down)
--'D' key press for going right
  if key == 100 and down then
    if player1.facing.left then
      playerTransition(player1, key)
    else
      player1.move.right = down
    end
--'D' key released
  elseif key == 100 and not down then
    anim:stop()
    idleanim:start()
    player1.move.right = false

--'A' key press for going left
  elseif key == 97 and down then
    if player1.facing.right then
      playerTransition(player1, key)
    else
      player1.move.left = down
    end
--'A' key released
  elseif key == 97 and not down then
    anim:stop()
    idleanim:start()
    player1.move.left = false

  elseif key == 97 and key == 100 and player1.onGround then
    player1.isIdle = true
    player1.move.left = false 
    player1.move.right = false
  end
--'W' key pressed for jump
  if key == 119 and down and player1.onGround then
    player1.jump = true
    player1.onGround = false
    
  end
--'S' key pressed for ducking
  if key == 115 and down then
   --Placeholder for now
   camera:moveScl(.2, .2, 5)

  end

end



--Run the transition animation when a player flips from left to right
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


---Function to calculate the speed of a player
function calculateSpeed(player)
      if player.move.right and not player.move.left then
      --Ramp up speed by adding 1 to speed until it hits max velocity
        if player.speed < values.playerSpeed then player.speed = player1.speed + 1 end

      elseif player.move.left and not player.move.right then
      --Ramp up speed by adding 1 to speed until it hits max velocity
        if player.speed < values.playerSpeed then player.speed = player.speed + 1 end
      
      end

      --If the player is moving apply wind resistance to slow him down
      if player.isIdle == false then
            
          if player.facing.right and player.speed > 0 then
            player.x = player.x + player.speed
            player.speed = player.speed - values.windResistance / 2
          elseif player.facing.left  and player.speed > 0 then
            player.x = player.x - player.speed
            player.speed = player.speed - values.windResistance / 2
         end
      end
end

--Various functions to handle player and world events
function calculateGravity(player)

        --Apply jump strength to the players jump
        if player.jump == true then
          player.jumpSpeed = values.playerForceUpwards
          player.jump = false
        end

        --Have gravity pull downwards on the player
        if player.onGround == false then
          player.y = player.y + player.jumpSpeed
          player.jumpSpeed = player.jumpSpeed - values.gravity
        end

        if player.y <= -512 and player.jump == false then
          player.onGround = true
        end
end

