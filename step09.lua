--make the block bounce on all edges of the screen

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
end
