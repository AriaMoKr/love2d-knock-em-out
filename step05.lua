--stop the box from going "too" low

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
  if blockY + blockHeight > 500 then
    blockY = 500 - blockHeight
  end
end

function love.draw()
  love.graphics.setColor(blockRed, blockGreen, blockBlue)
  love.graphics.rectangle("fill", blockX, blockY, blockWidth, blockHeight)
end
