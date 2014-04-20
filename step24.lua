--block bounce on paddle collision - prep2 use tables for colors

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  blockColor = {255, 0, 0}  
  paddleColor = {0, 0, 255}

  reset()
end

function bounceOnScreen()
  if blockPosX < 0 then
    blockVelocityX = -blockVelocityX
  end
  if blockPosX + blockWidth >= love.graphics.getWidth() then
    blockVelocityX = -blockVelocityX
  end
  if blockPosY < 0 then
    blockVelocityY = -blockVelocityY
  end
  if blockPosY + blockHeight >= love.graphics.getHeight() then
    blockVelocityY = -blockVelocityY
  end
end

function doesCollide()
--following - http://devmag.org.za/2009/04/13/basic-collision-detection-in-2d-part-1/  
  outsideTop = blockPosY + blockHeight < paddlePosY
  outsideBottom = blockPosY > paddlePosY + paddleHeight
  outsideLeft = blockPosX + blockWidth < paddlePosX
  outsideRight = blockPosX > paddlePosX + paddleWidth
  return not (outsideTop or outsideBottom or outsideLeft or outsideRight)
end

function bounceOnPaddle()
  if doesCollide() then
    
    --get paddle edges incl normals
    edge1 = {x1 = 0, y1 = 0, x2 = 10, y2 = 0, nx = 0, ny = 1}
    --
    
    blockVelocityX = 0
    blockVelocityY = 0
  end
end

function love.update(dt)
  blockPosX = blockPosX + blockVelocityX
  blockPosY = blockPosY + blockVelocityY
  
  bounceOnScreen()
  bounceOnPaddle()
  
  if love.keyboard.isDown("left") then
    paddlePosX = paddlePosX - dt * 500
  end
  if love.keyboard.isDown("right") then
    paddlePosX = paddlePosX + dt * 500
  end
  
  if(paddlePosX < 0) then
    paddlePosX = 0
  end
  if(paddlePosX + paddleWidth > love.graphics.getWidth()) then
    paddlePosX = love.graphics.getWidth() - paddleWidth
  end
end

function love.draw()
  love.graphics.setColor(blockColor)
  love.graphics.rectangle("fill", blockPosX, blockPosY, blockWidth, blockHeight)
  
  love.graphics.setColor(paddleColor)
  love.graphics.rectangle("fill", paddlePosX, paddlePosY, paddleWidth, paddleHeight)
end

function reset()
  blockPosX = 26
  blockPosY = 282
  blockWidth = 50
  blockHeight = 50
  blockVelocityX = 1
  blockVelocityY = 1

  paddlePosX = 68
  paddlePosY = 506
  paddleWidth = 260
  paddleHeight = 50
  paddleVelocityX = 1
  paddleVelocityY = 1
end

function love.keyreleased(key)
  if key == "r" then
    reset()
  end
  if key == "escape" then
    love.event.quit()
  end
end
