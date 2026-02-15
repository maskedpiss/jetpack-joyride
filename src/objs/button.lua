local Button = {}

function Button.new(text, x, y, callback)
  local instance = {}
  setmetatable(instance, { __index = Button })
  
  instance.text = text
  instance.sprite = Globals.Graphics.Sprites.Button
  instance.width = 200
  instance.height = 60
  instance.x = x - (instance.width / 2)
  instance.y = y - (instance.height / 2)
  instance.callback = callback or function() end

  instance:animate()
  
  return instance
end


function Button:animate()
  local frameWidth = self.width
  local frameHeight = self.height

  self. buttonFrames = Globals.Animation:parseSpriteSheet(self.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
end


function Button:update(dt)
  local mouseX, mouseY = love.mouse.getPosition()
  if self:isHovering(mouseX, mouseY) then
	self.currentFrame = 2
  else
  	self.currentFrame = 1
  end
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
  love.graphics.draw(self.sprite, self.buttonFrames[self.currentFrame], self.x, self.y)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.ButtonFont)
  local fontHeight = Globals.Graphics.Fonts.ButtonFont:getHeight()
  local textY = self.y + (self.height / 2) - (fontHeight / 2)
  love.graphics.printf(self.text, self.x, textY, self.width, "center")
end

return Button
