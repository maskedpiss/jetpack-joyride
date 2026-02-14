local Zapper = {}

function Zapper.new()
  local instance = {}
  setmetatable(instance, { __index = Zapper })
  
  instance:reset()
  
  return instance
end


function Zapper:reset()
  self.Generator = {
  	sprite = Globals.Graphics.Sprites.LaserGenerator,
  	x = Globals.Screen.width,
  	y = math.random(50, (Globals.Screen.height - 150)),
  	width = Globals.Graphics.Sprites.LaserGenerator:getWidth(),
  	height = Globals.Graphics.Sprites.LaserGenerator:getHeight(),
  	speed = 150
  }

  local h = 25
  self.Laser = {
    sprite = Globals.Graphics.Sprites.LaserBeam,
  	width = 200,
  	height = h,
  	y = (self.Generator.y + (h / 2)) + 4
  }
end


function Zapper:update(dt)
  self.Generator.x = self.Generator.x - self.Generator.speed * dt

  if self.Generator.x + self.Generator.width < Globals.Screen.x then
	self:reset()
  end
end


function Zapper:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.Generator.sprite, self.Generator.x, self.Generator.y)
  love.graphics.draw(self.Generator.sprite, (self.Generator.x + self.Generator.width) + self.Laser.width, self.Generator.y)
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.Laser.sprite, (self.Generator.x + self.Generator.width), self.Laser.y)
end

return Zapper
