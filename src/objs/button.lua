local Button = {}

local buttonFont = love.graphics.newFont(32)

function Button.new(text, x, y)
  local instance = {}
  setmetatable(instance, { __index = Button })
  
  instance.text = text
  instance.x = x
  instance.y = y
  instance.width = 150
  instance.height = 75
  
  return instance
end


function Button:update(dt)
  
end


function Button:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(buttonFont)
  love.graphics.print(self.text, self.x, self.y)
end

return Button
