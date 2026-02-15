local Rocket = {}

local timer = 0
local frameDuration = 0.1

function Rocket.new()
  local instance = {}
  setmetatable(instance, { __index = Rocket })
  
  instance:reset()
  instance:animate()
  
  return instance
end


function Rocket:reset()
  self.sprite = Globals.Graphics.Sprites.Rocket
  self.x = Globals.Screen.width
  self.y = math.random(50, (Globals.Screen.height - 150))
  self.ox = 8
  self.oy = 11
  self.width = 64
  self.height = 16
  self.speed = math.random(200, 500)
  self.health = 2
end


function Rocket:animate()
  local frameWidth = 80
  local frameHeight = 40

  self.rocketFrames = Globals.Animation:parseSpriteSheet(self.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
end


function Rocket:update(dt)
  self.x = self.x - self.speed * dt
  
  if self.x + self.width < Globals.Screen.x then
    self:reset()
  end

  timer = timer + dt
  if timer > frameDuration then
	self.currentFrame = self.currentFrame + 1
	timer = 0
	if self.currentFrame > #self.rocketFrames then
		self.currentFrame = 1
	end
  end
end


function Rocket:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.sprite, self.rocketFrames[self.currentFrame], self.x, self.y)
end

return Rocket
