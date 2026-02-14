local Button = {}

function Button.new(text, x, y, callback)
  local instance = {}
  setmetatable(instance, { __index = Button })
  
  instance.text = text
  instance.sprite = Globals.Graphics.Sprites.Button
  instance.width = instance.sprite:getWidth()
  instance.height = instance.sprite:getHeight()
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
  love.graphics.draw(self.sprite, self.x, self.y)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.ButtonFont)
  local fontHeight = Globals.Graphics.Fonts.ButtonFont:getHeight()
  local textY = self.y + (self.height / 2) - (fontHeight / 2)
  love.graphics.printf(self.text, self.x, textY, self.width, "center")
end

return Button
