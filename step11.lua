--prepare for collisions!

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  blockRed = 255
  blockGreen = 0
  blockBlue = 0
  blockPosX = 5
  blockPosY = 5
  blockWidth = 50
  blockHeight = 50
  blockVelocityX = 5
  blockVelocityY = 5

  paddleRed = 0
  paddleGreen = 0
  paddleBlue = 255
  paddlePosX = 5
  paddlePosY = 117
  paddleWidth = 50
  paddleHeight = 50
  paddleVelocityX = 5
  paddleVelocityY = 5
end

function love.update()
  blockPosX = 26
  blockPosY = 282
  
  paddlePosX = 68
  paddlePosY = 506
  paddleWidth = 260
  paddleHeight = 50
  
  blockPosX = blockPosX + blockVelocityX
  blockPosY = blockPosY + blockVelocityY
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

function love.draw()
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockPosX, blockPosY, blockWidth, blockHeight)
  
  love.graphics.setColor(paddleRed, paddleGreen, paddleBlue)
  love.graphics.rectangle("fill", paddlePosX, paddlePosY, paddleWidth, paddleHeight)
end
