local Zapper = {}

function Zapper.new()
  local instance = {}
  setmetatable(instance, { __index = Zapper })

  instance.generatorSprite = Globals.Graphics.Sprites.LaserGenerator
  instance.laserSprite = Globals.Graphics.Sprites.LaserBeam

  instance.currentState = "off"
  instance.timer = 0
  instance.frameDuration = 0.1
  instance.animDirection = -1
  instance.currentFrame = 1
  
  instance:reset()
  instance:animate()
  
  return instance
end


function Zapper:reset(orientation)
  self.states = {
  	OFF = "off",
  	TRANSITION = "transition",
  	ON = "on"
  }

  self.orientation = orientation or (math.random() > 0.5 and "horizontal" or "vertical")
  self.x = Globals.Screen.width + 100

  local padding = 50
  local totalHeight = (self.orientation == "vertical") and 320 or 60
  self.y = math.random(padding, Globals.Screen.height - totalHeight - padding)

  self.currentState = self.states.OFF

  self.genSize = 60
  self.beamLength = 200
  self.beamThick = 25
  self.speed = 150

  self.health = 3

  self.animSpeed = 100
  self.currentFrame = 1
  self.laserFrame = 1
  self.isPoweredOn = false
  self.hasHitPlayer = false
  self.isDestroyed = false

  if self.orientation == "horizontal" then
	self.hitBoxOffset = {
		x = self.genSize,
		y = (self.genSize / 2) - (self.beamThick / 2)
	}
	self.hitBoxDim = {
		w = self.beamLength,
		h = self.beamThick
	}
  else
	self.hitBoxOffset = {
		x = (self.genSize / 2) - (self.beamThick / 2),
		y = self.genSize
	}
	self.hitBoxDim = {
		w = self.beamThick,
		h = self.beamLength
	}
  end
end


function Zapper:animate()
  local frameWidth = 60
  local frameHeight = frameWidth

  self.GeneratorFrames = Globals.Animation:parseSpriteSheet(self.generatorSprite, frameWidth, frameHeight)
  self.currentFrame = 1

  local laserFrameWidth = 200
  local laserFrameHeight = 25

  self.LaserFrames = Globals.Animation:parseSpriteSheet(self.laserSprite, laserFrameWidth, laserFrameHeight)
end


function Zapper:checkCollision(player)
	if self.currentState ~= "on" or self.hasHitPlayer then
		return false
	end

	local bx = self.x + self.hitBoxOffset.x
	local by = self.y + self.hitBoxOffset.y
	local bw = self.hitBoxDim.w
	local bh = self.hitBoxDim.h

	return player.x < bx + bw and
		   bx < player.x + player.width and
		   player.y < by + bh and
		   by < player.y + player.height
end


function Zapper:getGeneratorHitboxes()
	local gen1 = {
		x = self.x,
		y = self.y,
		w = self.genSize,
		h = self.genSize
	}
	local gen2

	if self.orientation == "horizontal" then
		gen2 = {
			x = self.x + self.genSize + self.beamLength,
			y = self.y,
			w = self.genSize,
			h = self.genSize
		}
	else
		gen2 = {
			x = self.x,
			y = self.y + self.genSize + self.beamLength,
			w = self.genSize,
			h = self.genSize
		}
	end

	return gen1, gen2
end


function Zapper:checkBulletCollision(bullet)
	if self.isDestroyed then
		return false
	end

	local g1, g2 = self:getGeneratorHitboxes()
	local targets = {
		g1,
		g2
	}

	for _, box in ipairs(targets) do
		if bullet.x < box.x + box.w and
		   box.x < bullet.x + bullet.width and
		   bullet.y < box.y + box.h and
		   box.y < bullet.y + bullet.height then

			self:takeDamage(1)
			return true
		end
	end
	return false
end


function Zapper:takeDamage(amount)
	self.health = self.health - amount

	if self.health <= 0 and not self.isDestroyed then
		self.isDestroyed = true
		self.hasHitPlayer = true
		self.currentFrame = 3
	end
end


function Zapper:update(dt)
  self.x = self.x - self.speed * dt

  if self.hasHitPlayer and self.currentState == self.states.ON then
	self.currentState = self.states.TRANSITION
	self.animDirection = 1
  end

  if self.isDestroyed then
	self.currentFrame = 3
  elseif self.isPoweredOn then
	self.currentFrame = 1
  else
	self.currentFrame = 2
  end

  if self.currentState == self.states.OFF then
  	self.laserFrame = 28
  	self.animDirection = -1
  	self.isPoweredOn = false
  elseif self.currentState == self.states.TRANSITION then
    self.isPoweredOn = false
  	self.laserFrame = self.laserFrame + (self.animSpeed * dt * self.animDirection)

  	if self.laserFrame > #self.LaserFrames then
		self.laserFrame = #self.LaserFrames
  	elseif self.laserFrame < 1 then
		self.laserFrame = 1
  	end

  	if self.animDirection == 1 and self.laserFrame >= #self.LaserFrames then
  		self.currentState = self.states.OFF
  	elseif self.animDirection == -1 and self.laserFrame <= 5 then
  		self.currentState = self.states.ON
  	end
  elseif self.currentState == self.states.ON and not self.hasHitPlayer then
  	self.isPoweredOn = true
  	self.animDirection = 1

  	self.timer = self.timer + dt
  	if self.timer >= self.frameDuration then
		self.timer = 0
		self.laserFrame = self.laserFrame + 1

		if self.laserFrame > 4 then
			self.laserFrame = 1
		end
  	end
  end

  local fullWidth = (self.orientation == "horizontal") and (self.genSize * 2 + self.beamLength) or self.genSize

  if self.x + fullWidth < Globals.Screen.width and self.currentState == self.states.OFF and not self.hasHitPlayer then
	self.currentState = self.states.TRANSITION
	self.animDirection = -1
	self.laserFrame = 28
  end
  
  if self.x + fullWidth < 0 then
	self:reset()
  end
end


function Zapper:draw()
  love.graphics.setColor(1, 1, 1)

  local gx, gy = self.x, self.y
  local rawFrame = self.laserFrame or 1
  local frameIdx = math.floor(rawFrame)
  
  frameIdx = math.max(1, math.min(frameIdx, #self.LaserFrames))

  local quad = self.LaserFrames[frameIdx]

  if not quad then
	return
  end
  
  if self.orientation == "horizontal" then
	love.graphics.draw(self.generatorSprite, self.GeneratorFrames[self.currentFrame], gx, gy)
	love.graphics.draw(self.laserSprite, self.LaserFrames[math.floor(self.laserFrame)], gx + self.genSize, gy + (self.genSize / 2), 0, 1, 1, 0, self.beamThick / 2)
	love.graphics.draw(self.generatorSprite, self.GeneratorFrames[self.currentFrame], gx + self.genSize + self.beamLength, gy)
  else
	love.graphics.draw(self.generatorSprite, self.GeneratorFrames[self.currentFrame], gx, gy)
	love.graphics.draw(self.laserSprite, self.LaserFrames[math.floor(self.laserFrame)], gx + (self.genSize / 2), gy + self.genSize, math.pi / 2, 1, 1, 0, self.beamThick / 2)
	love.graphics.draw(self.generatorSprite, self.GeneratorFrames[self.currentFrame], gx, gy + self.genSize + self.beamLength)
  end
end

return Zapper
