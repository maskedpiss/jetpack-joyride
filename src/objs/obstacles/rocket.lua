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

  self.states = {
  	FLYING = "flying",
  	EXPLODING = "exploding"
  }
  self.state = self.states.FLYING
end


function Rocket:animate()
  local frameWidth = 80
  local frameHeight = 40

  self.rocketFrames = Globals.Animation:parseSpriteSheet(self.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
  self.explodeFrame = 29
end


function Rocket:update(dt)
  self.x = self.x - self.speed * dt

  if self.state == self.states.FLYING then
	if self.x + self.width < Globals.Screen.x then
	  self:reset()
	end

	if self.health <= 0 then
		self.state = self.states.EXPLODING
	end

	timer = timer + dt
	if timer >= frameDuration then
		timer = 0
		self.currentFrame = self.currentFrame + 1

		if self.currentFrame > 10 then
			self.currentFrame = 1
		end
	end
  elseif self.state == self.states.EXPLODING then
  	local newFrameDuration = 0.01
  	timer = timer + dt
  	if timer >= newFrameDuration then
		timer = 0
		self.explodeFrame = self.explodeFrame + 1

		if self.explodeFrame > #self.rocketFrames then
			return true
		end
  	end
  end
  return false
end


function Rocket:draw()
  love.graphics.setColor(1, 1, 1)

  if self.state == self.states.FLYING then
  	love.graphics.draw(self.sprite, self.rocketFrames[self.currentFrame], self.x, self.y)
  elseif self.state == self.states.EXPLODING then
	love.graphics.draw(self.sprite, self.rocketFrames[self.explodeFrame], self.x, self.y)
  end
end

return Rocket
