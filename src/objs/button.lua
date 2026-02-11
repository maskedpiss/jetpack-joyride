local Button = {}

local buttonFont = love.graphics.newFont(32)

function Button.new(text, x, y, callback)
  local instance = {}
  setmetatable(instance, { __index = Button })
  
  instance.text = text
  instance.width = 150
  instance.height = 75
  instance.x = x - (instance.width / 2)
  instance.y = y - (instance.height / 2)
  instance.callback = callback or function() end
  
  return instance
end


function Button:update(dt)
  
end


function Button:isHovering(x, y)
  return x > self.x and x < self.x + self.width and
         y > self.y and y < self.y + self.height
end


function Button:mousepressed(x, y, button)
  if self:isHovering(x, y) and button == 1 then
    self:callback()
    return true
  end
  return false
end


function Button:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(buttonFont)
  love.graphics.print(self.text, self.x, self.y)
end

return Button
