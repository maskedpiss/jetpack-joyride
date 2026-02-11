local Rocket = {}

function Rocket.new()
  local instance = {}
  setmetatable(instance, { __index = Rocket })
  
  instance:reset()
  
  return instance
end


function Rocket:reset()
  self.x = Globals.Screen.width / 2
  self.y = math.random(50, (Globals.Screen.height - 150))
  self.width = 100
  self.height = 50
  self.speed = math.random(200, 500)
end


function Rocket:update(dt)
  self.x = self.x - self.speed * dt
end


function Rocket:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Rocket
