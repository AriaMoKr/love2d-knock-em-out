--try moving a box in update

function love.update()
  blockX = blockX + 1
end

function love.draw()
  blockRed = 0
  blockGreen = 0
  blockBlue = 255
  blockX = 5
  blockY = 5
  blockWidth = 50
  blockHeight = 50
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockX, blockY, blockWidth, blockHeight)
end
