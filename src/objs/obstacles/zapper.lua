local Zapper = {}

function Zapper.new()
  local instance = {}
  setmetatable(instance, { __index = Zapper })
  
  instance:reset()
  
  return instance
end


function Zapper:reset()
  self.x = Globals.Screen.width
  self.y = math.random(50, (Globals.Screen.height - 150))
  self.width = 200
  self.height = 25
  self.speed = 200
end


function Zapper:update(dt)
  self.x = self.x - self.speed * dt
  
  if self.x + self.width < Globals.Screen.x then
    self:reset()
  end
end


function Zapper:draw()
  love.graphics.setColor(1, 1, 0)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Zapper
