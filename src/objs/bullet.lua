local Bullet = {}

Bullet.cooldownTimer = 0.15

function Bullet.new(x, y)
  local instance = {}
  setmetatable(instance, { __index = Bullet })
  
  instance.x = x
  instance.y = y
  instance.width = 5
  instance.height = 5
  instance.speed = 500
  
  return instance
end


function Bullet:shoot(x, y)
  if Bullet.cooldownTimer <= 0 then
    local newBullet = Bullet.new(x, y)
    table.insert(Globals.Bullets, newBullet)
    Bullet.cooldownTimer = 0.15
  end
end


function Bullet:update(dt)
  for i, bullet in ipairs(Globals.Bullets) do
    bullet.y = bullet.y + bullet.speed * dt
  end
  
  Bullet.cooldownTimer = Bullet.cooldownTimer - dt
end


function Bullet:draw()
  for i, bullet in ipairs(Globals.Bullets) do
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", bullet.x, bullet.y, bullet.width, bullet.height)
  end
end

return Bullet
