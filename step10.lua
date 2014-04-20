--add the paddle

function love.load()
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
  paddlePosY = 5
  paddleWidth = 50
  paddleHeight = 50
  paddleVelocityX = 5
  paddleVelocityY = 5
end

function love.update()
  paddlePosX = 223
  paddlePosY = 169
  paddleWidth = 122
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
