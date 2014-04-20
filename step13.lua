--add bounceOnScreen and empty bounceOnPaddle

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  blockRed = 255
  blockGreen = 0
  blockBlue = 0
  blockPosX = 26
  blockPosY = 282
  blockWidth = 50
  blockHeight = 50
  blockVelocityX = 1
  blockVelocityY = 1
  
  paddleRed = 0
  paddleGreen = 0
  paddleBlue = 255
  paddlePosX = 68
  paddlePosY = 506
  paddleWidth = 260
  paddleHeight = 50
  paddleVelocityX = 1
  paddleVelocityY = 1
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

function bounceOnPaddle()
end

function love.update()
  blockPosX = blockPosX + blockVelocityX
  blockPosY = blockPosY + blockVelocityY
  bounceOnScreen()
  bounceOnPaddle()
end

function love.draw()
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockPosX, blockPosY, blockWidth, blockHeight)
  
  love.graphics.setColor(paddleRed, paddleGreen, paddleBlue)
  love.graphics.rectangle("fill", paddlePosX, paddlePosY, paddleWidth, paddleHeight)
end
