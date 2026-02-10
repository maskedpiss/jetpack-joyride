local Player = {}

function Player.new(x, y)
  local instance = {}
  setmetatable(instance, { __index = Player })
  
  instance.x = x
  instance.y = y
  instance.width = 20
  instance.height = 40
  
  return instance
end


function Player:update(dt)
  
end


function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
