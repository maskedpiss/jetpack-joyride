local Zapper = {}

local timer = 0
local frameDuration = 0.1

local states = {
	OFF = "off",
	TRANSITION = "transition",
	ON = "on"
}

local currentState = states.OFF
local animSpeed = 100
local animDirection = -1

function Zapper.new()
  local instance = {}
  setmetatable(instance, { __index = Zapper })
  
  instance:reset()
  instance:animate()
  
  return instance
end


function Zapper:reset()
  self.Generator = {
  	sprite = Globals.Graphics.Sprites.LaserGenerator,
  	x = Globals.Screen.width,
  	y = math.random(50, (Globals.Screen.height - 150)),
  	width = 60,
  	height = Globals.Graphics.Sprites.LaserGenerator:getHeight(),
  	speed = 150,
  	health = 3
  }

  local h = 25
  self.Laser = {
    sprite = Globals.Graphics.Sprites.LaserBeam,
  	width = 200,
  	height = h,
  	x = self.Generator.x + self.Generator.width,
  	y = (self.Generator.y + (h / 2)) + 4,
  	ox = 0,
  	oy = 0,
  	currentFrame = 1
  }

  self.genHitBox2 = {
  	x = self.Laser.x + self.Laser.width,
  	y = self.Generator.y,
  	width = self.Generator.width,
  	height = self.Generator.height
  }

  self.totalWidth = (self.Generator.width * 2) + self.Laser.width
  self.isPoweredOn = false
  self.isDestroyed = false
  self.hasBeenHit = false
  currentState = states.OFF
end


function Zapper:animate()
  local frameWidth = 60
  local frameHeight = frameWidth

  self.GeneratorFrames = Globals.Animation:parseSpriteSheet(self.Generator.sprite, frameWidth, frameHeight)
  self.currentFrame = 1

  local laserFrameWidth = self.Laser.width
  local laserFrameHeight = self.Laser.height

  self.LaserFrames = Globals.Animation:parseSpriteSheet(self.Laser.sprite, laserFrameWidth, laserFrameHeight)
  self.Laser.currentFrame = 1
end


function Zapper:update(dt)
  self.Generator.x = self.Generator.x - self.Generator.speed * dt
  self.Laser.x = self.Laser.x - self.Generator.speed * dt
  self.genHitBox2.x = self.genHitBox2.x - self.Generator.speed * dt

  if self.Generator.x + self.totalWidth < Globals.Screen.x then
	self:reset()
  end

  if currentState == states.OFF then
  	self.Laser.currentFrame = 28
  	animDirection = -1
  elseif currentState == states.TRANSITION then
  	self.Laser.currentFrame = self.Laser.currentFrame + (animSpeed * dt * animDirection)

  	if animDirection == 1 and self.Laser.currentFrame >= #self.LaserFrames then
  		currentState = states.OFF
  	elseif animDirection == -1 and self.Laser.currentFrame <= 5 then
  		currentState = states.ON
  	end
  elseif currentState == states.ON then
  	animDirection = 1

  	timer = timer + dt
  	if timer >= frameDuration then
		timer = 0
		self.Laser.currentFrame = self.Laser.currentFrame + 1

		if self.Laser.currentFrame > 4 then
			self.Laser.currentFrame = 1
		end
  	end
  end

  if self.Generator.x + self.totalWidth < Globals.Screen.width and self.Generator.health > 0 and not self.hasBeenHit then
  	self.isPoweredOn = true
  	if currentState == states.OFF then
		currentState = states.TRANSITION
  	end
  end

  if self.Generator.health <= 0 then
  	self.isPoweredOn = false
  	self.isDestroyed = true
  	currentState = states.TRANSITION
  end

  if self.hasBeenHit then
	currentState = states.TRANSITION
  end

  if self.isPoweredOn and not self.isDestroyed then
	self.currentFrame = 1
  elseif not self.isPoweredOn and not self.isDestroyed then
  	self.currentFrame = 2
  end

  if self.isDestroyed then
	self.currentFrame = 3
  end
end


function Zapper:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.Generator.sprite, self.GeneratorFrames[self.currentFrame], self.Generator.x, self.Generator.y)
  love.graphics.draw(self.Generator.sprite, self.GeneratorFrames[self.currentFrame], (self.Generator.x + self.Generator.width) + self.Laser.width, self.Generator.y)
  
  love.graphics.setColor(1, 1, 1)
  local frameIdx = math.floor(self.Laser.currentFrame)
  frameIdx = math.max(1, math.min(frameIdx, #self.LaserFrames))
  love.graphics.draw(self.Laser.sprite, self.LaserFrames[frameIdx], self.Laser.x, self.Laser.y)
end

return Zapper
