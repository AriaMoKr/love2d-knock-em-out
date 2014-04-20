--draw bricks

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  block = {}
  block.Color = {255, 0, 0}  
  
  paddle = {}
  paddle.Color = {0, 0, 255}
  
  bricks = {}
  bricks.PosX = 5
  bricks.PosY = 5
  bricks.CountX = 3
  bricks.CountY = 3
  bricks.Width = 30
  bricks.Height = 10
  bricks.Color = {0, 255, 0}

  reset()
end

function bounceOnScreen()
  if block.PosX < 0 then
    block.VelocityX = -block.VelocityX
  end
  if block.PosX + block.Width >= love.graphics.getWidth() then
    block.VelocityX = -block.VelocityX
  end
  if block.PosY < 0 then
    block.VelocityY = -block.VelocityY
  end
  --if block.PosY + block.Height >= love.graphics.getHeight() then
  --  block.VelocityY = -block.VelocityY
  --end
end

function doesCollide()
--following - http://devmag.org.za/2009/04/13/basic-collision-detection-in-2d-part-1/  
  outsideTop = block.PosY + block.Height < paddle.PosY
  outsideBottom = block.PosY > paddle.PosY + paddle.Height
  outsideLeft = block.PosX + block.Width < paddle.PosX
  outsideRight = block.PosX > paddle.PosX + paddle.Width
  return not (outsideTop or outsideBottom or outsideLeft or outsideRight)
end

function bounceOnPaddle()
  if doesCollide() then
    
    --get paddle edges incl normals
--    topEdge = {x1 = paddle.PosX, y1 = paddle.PosY, x2 = paddle.PosX + paddle.Width, y2 = paddle.PosY + paddle.Height, nx = 0, ny = -1}
--    rightEdge = {x1 = paddle.PosX + paddle.Width, y1 = paddle.PosY, x2 = paddle.PosX + paddle.Width, y2 = paddle.PosY + paddle.Height, nx = 1, ny = 0}
--    bottomEdge = {x1 = paddle.PosX + paddle.Width, y1 = paddle.PosY + paddle.Height, x2 = paddle.PosX, y2 = paddle.PosY + paddle.Height, nx = 0, ny = 1}
--    leftEdge = {x1 = paddle.PosX, y1 = paddle.PosY + paddle.Height, x2 = paddle.PosX, y2 = paddle.PosY, nx = -1, ny = 0}

    --check horizontal collision:
    leftEdgeCollision = block.PosX < paddle.PosX
    rightEdgeCollision = block.PosX + block.Width >= paddle.PosX + paddle.Width
    if leftEdgeCollision or rightEdgeCollision then
      block.VelocityX = -block.VelocityX
      return
    end

    -- check vertical collision:
    topEdgeCollision = block.PosY < paddle.PosY
    bottomEdgeCollision = block.PosY + block.Height >= paddle.PosY + paddle.Height
    if topEdgeCollision or bottomEdgeCollision then
      block.VelocityY = -block.VelocityY
      return
    end
        
    block.VelocityX = 0
    block.VelocityY = 0
  end
end

function handleKeyboard(dt)
  newPaddleX = paddle.PosX
  
  if love.keyboard.isDown("left") then
    newPaddleX = newPaddleX - dt * 500
  end
  if love.keyboard.isDown("right") then
    newPaddleX = newPaddleX + dt * 500
  end
  
  if(newPaddleX < 0) then
    newPaddleX = 0
  end
  if(newPaddleX + paddle.Width > love.graphics.getWidth()) then
    newPaddleX = love.graphics.getWidth() - paddle.Width
  end
  
  if not doesCollide() then
    paddle.PosX = newPaddleX
  end
end

function moveBlock(dt)
  newBlockX = block.PosX + block.VelocityX * dt
  newBlockY = block.PosY + block.VelocityY * dt
  
  --if not doesCollide() then
  block.PosX = newBlockX
  block.PosY = newBlockY
  --end
  
end

function love.update(dt)
  
  moveBlock(dt)
  
  bounceOnScreen()
  bounceOnPaddle()
  
  handleKeyboard(dt)
end

function drawBricks()
  bricks.PosX = 13
  bricks.PosY = 25
  bricks.CountX = 10
  bricks.CountY = 3
  bricks.Width = 65
  bricks.Height = 26
  bricks.Color = {0, 255, 0}
  bricks.SpacingX = 14
  bricks.SpacingY = -31

  for y = 0,bricks.CountY-1 do
    for x = 0,bricks.CountX-1 do
      love.graphics.setColor(bricks.Color)
        
      love.graphics.rectangle("fill", bricks.PosX + (bricks.Width + bricks.SpacingX) * x, bricks.PosY + (bricks.Width + bricks.SpacingY) * y, bricks.Width, bricks.Height)
    end
  end  
end

function love.draw()
  love.graphics.setColor(block.Color)
  love.graphics.rectangle("fill", block.PosX, block.PosY, block.Width, block.Height)
  
  love.graphics.setColor(paddle.Color)
  love.graphics.rectangle("fill", paddle.PosX, paddle.PosY, paddle.Width, paddle.Height)
  
  drawBricks()
end

function reset()
  block.PosX = 26
  block.PosY = 282
  block.Width = 50
  block.Height = 50
  block.VelocityX = 100
  block.VelocityY = 100

  paddle.PosX = 68
  paddle.PosY = 506
  paddle.Width = 260
  paddle.Height = 50
  paddle.VelocityX = 0
  paddle.VelocityY = 0
end

function love.keyreleased(key)
  if key == "r" then
    reset()
  end
  if key == "escape" then
    love.event.quit()
  end
end
