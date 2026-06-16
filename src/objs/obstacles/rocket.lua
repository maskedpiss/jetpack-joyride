local Rocket = {}

local animTimer = 0
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
  self.speed = math.random(400, 500)
  self.health = 1

  self.indicator = {
  	sprite = Globals.Graphics.Sprites.RocketIndicator,
  	x = Globals.Screen.width - 100,
  	y = 0
  }

  self.states = {
  	HOMING = "homing",
  	FLYING = "flying",
  	EXPLODING = "exploding"
  }
  self.state = self.states.HOMING
  self.homingTimer = 3

  if Globals.Sound and Globals.Sound.SFX.RocketLock then
	Globals.Sound.SFX.RocketLock:setLooping(true)
	Globals.Sound:playSound(Globals.Sound.SFX.RocketLock)
  end
end


function Rocket:animate()
  local indWidth = 30
  local indHeight = 30

  self.indicatorFrames = Globals.Animation:parseSpriteSheet(self.indicator.sprite, indWidth, indHeight)
  self.currentIndFrame = 1

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

		if Globals.Sound then
			if Globals.Sound.SFX.RocketLock then Globals.Sound.SFX.RocketLock:stop() end
			if Globals.Sound.SFX.RocketLaunch then
				Globals.Sound.SFX.RocketLaunch:seek(0)
				Globals.Sound:playSound(Globals.Sound.SFX.RocketLaunch)
			end
		end
  	end

  	animTimer = animTimer + dt
  	if animTimer >= frameDuration then
		animTimer = 0
		self.currentIndFrame = self.currentIndFrame + 1

		if self.currentIndFrame > #self.indicatorFrames then
			self.currentIndFrame = 1
		end
  	end
  elseif self.state == self.states.FLYING then
	if self.x + self.width < Globals.Screen.x then
	  self:reset()
	end

	if self.health <= 0 then
		self.state = self.states.EXPLODING

		if Globals.Sound then
			if Globals.Sound.SFX.RocketLaunch then Globals.Sound.SFX.RocketLaunch:stop() end
			Globals.Sound:playSound(Globals.Sound.SFX.RocketExplode)
		end
	end

	animTimer = animTimer + dt
	if animTimer >= frameDuration then
		animTimer = 0
		self.currentFrame = self.currentFrame + 1

		if self.currentFrame > 10 then
			self.currentFrame = 1
		end
	end
  elseif self.state == self.states.EXPLODING then
  	local newFrameDuration = 0.015
  	animTimer = animTimer + dt
  	if animTimer >= newFrameDuration then
		animTimer = 0
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
  	love.graphics.setColor(1, 1, 1)
  	love.graphics.draw(self.indicator.sprite, self.indicatorFrames[self.currentIndFrame], self.indicator.x, self.indicator.y)
  elseif self.state == self.states.FLYING then
    love.graphics.setColor(1, 1, 1)
  	love.graphics.draw(self.sprite, self.rocketFrames[self.currentFrame], self.x, self.y)
  elseif self.state == self.states.EXPLODING then
    love.graphics.setColor(1, 1, 1)
	love.graphics.draw(self.sprite, self.rocketFrames[self.explodeFrame], self.x, self.y)
  end
end

return Rocket
