--handle bricks - collide with bricks

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  block = {}
  block.Color = {255, 0, 0}  
  
  paddle = {}
  paddle.Color = {0, 0, 255}
  
  bricks = {}
  bricks.PosX = 13
  bricks.PosY = 25
  bricks.CountX = 10
  bricks.CountY = 3
  bricks.Width = 65
  bricks.Height = 26
  bricks.Color = {0, 255, 0}
  bricks.SpacingX = 14
  bricks.SpacingY = 31
  
  newGame()
end

function newGame()
  setupBricks()

  reset()
end

function setupBricks()
  bricks.bricks = {}
  
  i = 0
  for y = 0,bricks.CountY-1 do
    for x = 0,bricks.CountX-1 do
      brick = {}
      brick.PosX = bricks.PosX + (bricks.Width + bricks.SpacingX) * x
      brick.PosY = bricks.PosY + (bricks.Height + bricks.SpacingY) * y
      brick.Width = bricks.Width
      brick.Height = bricks.Height
      brick.Color = bricks.Color
      brick.Alive = true
      
      bricks.bricks[i] = brick
      i = i + 1
    end
  end
  
 
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
end

function doesCollide(rect)
--following - http://devmag.org.za/2009/04/13/basic-collision-detection-in-2d-part-1/  
  outsideTop = block.PosY + block.Height < rect.PosY
  outsideBottom = block.PosY > rect.PosY + rect.Height
  outsideLeft = block.PosX + block.Width < rect.PosX
  outsideRight = block.PosX > rect.PosX + rect.Width
  return not (outsideTop or outsideBottom or outsideLeft or outsideRight)
end

--TODO cleanup - just dupe of bounceOnPaddle
function bounceOnRect(rect)
  if doesCollide(rect) then
    
    --check horizontal collision:
    leftEdgeCollision = block.PosX < rect.PosX
    rightEdgeCollision = block.PosX + block.Width > rect.PosX + rect.Width
    
    -- check vertical collision:
    topEdgeCollision = block.PosY < rect.PosY
    bottomEdgeCollision = block.PosY + block.Height > rect.PosY + rect.Height

    horizontalCollision = leftEdgeCollision or rightEdgeCollision
    verticalCollision = topEdgeCollision or bottomEdgeCollision

    if horizontalCollision and verticalCollision then
      block.VelocityX = -block.VelocityX
      block.VelocityY = -block.VelocityY
      return
    end

    if leftEdgeCollision or rightEdgeCollision then
      block.VelocityX = -block.VelocityX
      return
    end

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
  
  if not doesCollide(paddle) then
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

function bounceOnBricks()
  for i = 0,#bricks.bricks do
    b = bricks.bricks[i]
    if b.Alive and doesCollide(b) then
      bounceOnRect(b)
      b.Alive = false
    end
  end
end

function love.update(dt)
  
  moveBlock(dt)
  
  bounceOnBricks()
  bounceOnRect(paddle)
  bounceOnScreen()
  
  handleKeyboard(dt)
end

function drawBrick(brickIndex)
  b = bricks.bricks[brickIndex]
  if b.Alive then
    love.graphics.setColor(b.Color)
    love.graphics.rectangle("fill", b.PosX, b.PosY, b.Width, b.Height)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("line", b.PosX, b.PosY, b.Width, b.Height)
  end
end

function drawBricks()
  for i = 0,#bricks.bricks do
    drawBrick(i)
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
  if key == "n" then
    newGame()
  end
  if key == "r" then
    reset()
  end
  if key == "escape" then
    love.event.quit()
  end
end
