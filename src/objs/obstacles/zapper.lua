local Zapper = {}

local states = {
	OFF = "off",
	TRANSITION = "transition",
	ON = "on"
}

function Zapper.new()
  local instance = {}
  setmetatable(instance, { __index = Zapper })

  instance.currentState = "off"
  instance.timer = 0
  instance.animSpeed = 100
  instance.animDirection = -1
  instance.frameDuration = 0.1
  instance.currentFrame = 1
  
  instance:reset()
  instance:animate()
  
  return instance
end


function Zapper:reset(orientation)
  self.orientation = orientation or (math.random() > 0.5 and "horizontal" or "vertical")

  self.Generator = {
  	sprite = Globals.Graphics.Sprites.LaserGenerator,
  	x = Globals.Screen.width + 100,
  	y = math.random(50, (Globals.Screen.height - 250)),
  	width = 60,
  	height = 60,
  	speed = 150,
  	health = 3
  }

  local beamLength = 200
  local beamThick = 25

  self.Laser = {
  	sprite = Globals.Graphics.Sprites.LaserBeam,
  	ox = 0,
  	oy = 0,
  	width = beamLength,
  	height = beamThick,
  	currentFrame = 1,
  	angle = 0
  }

  if self.orientation == "horizontal" then
    self.Laser.x = self.Generator.x + self.Generator.width
    self.Laser.y = self.Generator.y + (self.Generator.height / 2)
    self.Laser.angle = 0
    self.secondGenPos = {
    	x = self.Laser.x + beamLength,
    	y = self.Generator.y
    }
  else
    self.Laser.x = self.Generator.x + (self.Generator.width / 2)
    self.Laser.y = self.Generator.y + self.Generator.height
    self.Laser.angle = math.pi / 2
    self.secondGenPos = {
    	x = self.Generator.x,
    	y = self.Laser.y + beamLength
    }
  end

  self.HitBox = {
  	width = (self.orientation == "horizontal") and beamLength or beamThick,
  	height = (self.orientation == "vertical") and beamThick or beamLength
  }

  self.totalWidth = (self.orientation == "horizontal") and (self.Generator.width * 2 + beamLength) or self.Generator.width
  self.isPoweredOn = false
  self.isDestroyed = false
  self.hasBeenHit = false
  self.currentState = states.OFF
end


function Zapper:animate()
  local frameWidth = 60
  local frameHeight = frameWidth

  self.GeneratorFrames = Globals.Animation:parseSpriteSheet(self.Generator.sprite, frameWidth, frameHeight)

  local laserFrameWidth = self.Laser.width
  local laserFrameHeight = self.Laser.height

  self.LaserFrames = Globals.Animation:parseSpriteSheet(self.Laser.sprite, laserFrameWidth, laserFrameHeight)
end


function Zapper:update(dt)
  local move = self.Generator.speed * dt
  self.Generator.x = self.Generator.x - move
  self.Laser.x = self.Laser.x - move
  self.secondGenPos.x = self.secondGenPos.x - move

  if self.currentState == states.OFF then
  	self.Laser.currentFrame = 28
  	self.animDirection = -1
  elseif self.currentState == states.TRANSITION then
  	self.Laser.currentFrame = self.Laser.currentFrame + (self.animSpeed * dt * self.animDirection)

  	if self.animDirection == 1 and self.Laser.currentFrame >= #self.LaserFrames then
  		self.currentState = states.OFF
  	elseif self.animDirection == -1 and self.Laser.currentFrame <= 5 then
  		self.currentState = states.ON
  	end
  elseif self.currentState == states.ON then
  	self.animDirection = 1

  	self.timer = self.timer + dt
  	if self.timer >= self.frameDuration then
		self.timer = 0
		self.Laser.currentFrame = self.Laser.currentFrame + 1

		if self.Laser.currentFrame > 4 then
			self.Laser.currentFrame = 1
		end
  	end
  end

  if self.Generator.x < Globals.Screen.width and self.Generator.health > 0 and not self.hasBeenHit then
	self.isPoweredOne = true
	if self.currentState == states.OFF then
		self.currentState = states.TRANSITION
	end
  end

  if self.isDestroyed then
	self.currentFrame = 3
  elseif self.isPoweredOn then
  	self.currentFrame = 1
  else
  	self.currentFrame = 2
  end
end


function Zapper:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.Generator.sprite, self.GeneratorFrames[self.currentFrame], self.Generator.x, self.Generator.y)
  love.graphics.draw(self.Generator.sprite, self.GeneratorFrames[self.currentFrame], self.secondGenPos.x, self.secondGenPos.y)
  
  local frameIdx = math.floor(self.Laser.currentFrame or 1)
  frameIdx = math.max(1, math.min(frameIdx, #self.LaserFrames))
  love.graphics.draw(self.Laser.sprite, self.LaserFrames[frameIdx], self.Laser.x, self.Laser.y, self.Laser.angle, 1, 1, 0, self.Laser.height / 2)
end

return Zapper
