local Zapper = {}

function Zapper.new()
  local instance = {}
  setmetatable(instance, { __index = Zapper })
  
  instance.x = Globals.Screen.width / 2
  instance.y = Globals.Screen.height / 2
  instance.width = 200
  instance.height = 50
  
  return instance
end


function Zapper:update(dt)
  
end


function Zapper:draw()
  love.graphics.setColor(1, 1, 0)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Zapper
