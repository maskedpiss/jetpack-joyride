local Bullet = {}
Bullet.__index = Bullet

Bullet.cooldownTimer = 0.1

function Bullet.new(x, y)
  return setmetatable({
      x = x,
      y = y,
      width = 4,
      height = 8,
      speed = 700
  }, Bullet)
end


function Bullet:shoot(x, y, dt)
  Bullet.cooldownTimer = (Bullet.cooldownTimer or 0) - dt
  if Bullet.cooldownTimer <= 0 then
    table.insert(Globals.Bullets, Bullet.new(x, y))
    Bullet.cooldownTimer = 0.1
  end
end


function Bullet:update(dt)
  for i = #Globals.Bullets, 1, -1 do
    local b = Globals.Bullets[i]
    b.y = b.y + b.speed * dt
    
    if b.y > Globals.Screen.height then
      table.remove(Globals.Bullets, i)
    end
  end
end


function Bullet:draw()
  love.graphics.setColor(1, 0.9, 0)
  for i, bullet in ipairs(Globals.Bullets) do
    love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.width, bullet.height)
  end
end

return Bullet
