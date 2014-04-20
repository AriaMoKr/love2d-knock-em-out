--block bounce on paddle collision - prep4 create edges

function love.load(arg)
  if arg[#arg] == "-debug" then require("mobdebug").start() end
  
  block = {}
  block.Color = {255, 0, 0}  
  
  paddle = {}
  paddle.Color = {0, 0, 255}

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
  if block.PosY + block.Height >= love.graphics.getHeight() then
    block.VelocityY = -block.VelocityY
  end
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
    topEdge = {x1 = paddle.PosX, y1 = paddle.PosY, x2 = paddle.PosX + paddle.Width, y2 = paddle.PosY + paddle.Height, nx = 0, ny = -1}
    rightEdge = {x1 = paddle.PosX + paddle.Width, y1 = paddle.PosY, x2 = paddle.PosX + paddle.Width, y2 = paddle.PosY + paddle.Height, nx = 1, ny = 0}
    bottomEdge = {x1 = paddle.PosX + paddle.Width, y1 = paddle.PosY + paddle.Height, x2 = paddle.PosX, y2 = paddle.PosY + paddle.Height, nx = 0, ny = 1}
    leftEdge = {x1 = paddle.PosX, y1 = paddle.PosY + paddle.Height, x2 = paddle.PosX, y2 = paddle.PosY, nx = -1, ny = 0}
    
    block.VelocityX = 0
    block.VelocityY = 0
  end
end

function love.update(dt)
  block.PosX = block.PosX + block.VelocityX
  block.PosY = block.PosY + block.VelocityY
  
  bounceOnScreen()
  bounceOnPaddle()
  
  if love.keyboard.isDown("left") then
    paddle.PosX = paddle.PosX - dt * 500
  end
  if love.keyboard.isDown("right") then
    paddle.PosX = paddle.PosX + dt * 500
  end
  
  if(paddle.PosX < 0) then
    paddle.PosX = 0
  end
  if(paddle.PosX + paddle.Width > love.graphics.getWidth()) then
    paddle.PosX = love.graphics.getWidth() - paddle.Width
  end
end

function love.draw()
  love.graphics.setColor(block.Color)
  love.graphics.rectangle("fill", block.PosX, block.PosY, block.Width, block.Height)
  
  love.graphics.setColor(paddle.Color)
  love.graphics.rectangle("fill", paddle.PosX, paddle.PosY, paddle.Width, paddle.Height)
end

function reset()
  block.PosX = 26
  block.PosY = 282
  block.Width = 50
  block.Height = 50
  block.VelocityX = 1
  block.VelocityY = 1

  paddle.PosX = 68
  paddle.PosY = 506
  paddle.Width = 260
  paddle.Height = 50
  paddle.VelocityX = 1
  paddle.VelocityY = 1
end

function love.keyreleased(key)
  if key == "r" then
    reset()
  end
  if key == "escape" then
    love.event.quit()
  end
end
