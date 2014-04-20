--save the block stuff in load so we can then move a box in update

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
end

function love.draw()
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockX, blockY, blockWidth, blockHeight)
end
