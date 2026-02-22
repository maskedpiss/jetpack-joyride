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
  self.y = 0
  self.ox = 8
  self.oy = 11
  self.width = 64
  self.height = 16
  self.speed = math.random(200, 500)
  self.health = 2

  self.indicator = {
  	x = Globals.Screen.width - 100,
  	y = 0,
  	width = 20,
  	height = 20
  }

  self.states = {
  	HOMING = "homing",
  	FLYING = "flying",
  	EXPLODING = "exploding"
  }
  self.state = self.states.HOMING

  self.homingTimer = 3
end


function Rocket:animate()
  local frameWidth = 80
  local frameHeight = 40

  self.rocketFrames = Globals.Animation:parseSpriteSheet(self.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
  self.explodeFrame = 29
end


function Rocket:update(dt)
  if self.state == self.states.HOMING then
  	self.homingTimer = self.homingTimer - dt
  	if self.homingTimer <= 0 then
  		self.y = self.indicator.y
		self.state = self.states.FLYING
  	end
  elseif self.state == self.states.FLYING then
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
  	local newFrameDuration = 0.015
  	timer = timer + dt
  	if timer >= newFrameDuration then
		timer = 0
		self.explodeFrame = self.explodeFrame + 1

		if self.explodeFrame > #self.rocketFrames then
			return true
		end
  	end
  end

  if self.state ~= self.states.HOMING then
    self.x = self.x - self.speed * dt
  end
  return false
end


function Rocket:draw()
  if self.state == self.states.HOMING then
  	love.graphics.setColor(1, 0, 0)
  	love.graphics.rectangle("fill", self.indicator.x, self.indicator.y, self.indicator.width, self.indicator.height)
  elseif self.state == self.states.FLYING then
    love.graphics.setColor(1, 1, 1)
  	love.graphics.draw(self.sprite, self.rocketFrames[self.currentFrame], self.x, self.y)
  elseif self.state == self.states.EXPLODING then
    love.graphics.setColor(1, 1, 1)
	love.graphics.draw(self.sprite, self.rocketFrames[self.explodeFrame], self.x, self.y)
  end
end

return Rocket
