local Rocket = {}

function Rocket.new()
  local instance = {}
  setmetatable(instance, { __index = Rocket })
  
  instance:reset()
  
  return instance
end


function Rocket:reset()
  self.sprite = Globals.Graphics.Sprites.Rocket
  self.x = Globals.Screen.width
  self.y = math.random(50, (Globals.Screen.height - 150))
  self.width = self.sprite:getWidth()
  self.height = self.sprite:getHeight()
  self.speed = math.random(200, 500)
  self.health = 2
end


function Rocket:update(dt)
  self.x = self.x - self.speed * dt
  
  if self.x + self.width < Globals.Screen.x then
    self:reset()
  end
end


function Rocket:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.sprite, self.x, self.y)
end

return Rocket
