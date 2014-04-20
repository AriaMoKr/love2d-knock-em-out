--stop the block from going off the bottom or right side of the screen

function love.load()
  blockRed = 0
  blockGreen = 0
  blockBlue = 255
  blockX = 5
  blockY = 5
  blockWidth = 50
  blockHeight = 50
end

function love.update()
  blockX = blockX + 5
  blockY = blockY + 5
  if blockX + blockWidth > love.graphics.getWidth() then
    blockX = love.graphics.getWidth() - blockWidth
  end
  if blockY + blockHeight > love.graphics.getHeight() then
    blockY = love.graphics.getHeight() - blockHeight
  end
end

function love.draw()
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockX, blockY, blockWidth, blockHeight)
end
