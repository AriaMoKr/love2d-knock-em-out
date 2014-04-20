--don't just stop the block from going off the bottom or right side of the screen but make it bounce

function love.load()
  blockRed = 0
  blockGreen = 0
  blockBlue = 255
  blockPosX = 5
  blockPosY = 5
  blockWidth = 50
  blockHeight = 50
  blockVelocityX = 5
  blockVelocityY = 5
end

function love.update()
  blockPosX = blockPosX + blockVelocityX
  blockPosY = blockPosY + blockVelocityY
  if blockPosX + blockWidth > love.graphics.getWidth() then
    blockVelocityX = -blockVelocityX
  end
  if blockPosY + blockHeight > love.graphics.getHeight() then
    blockVelocityY = -blockVelocityY
  end
end

function love.draw()
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockPosX, blockPosY, blockWidth, blockHeight)
end
