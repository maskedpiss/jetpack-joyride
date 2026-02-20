local Bullet = {}
Bullet.__index = Bullet

local cooldownTimer = 0.1
local frameDuration = 0.1

function Bullet.new(x, y)
  local self = setmetatable({}, Bullet)
  self.sprite = Globals.Graphics.Sprites.Bullet
  self.hitSheet = Globals.Graphics.Sprites.BulletHit

  self.hitFrames = Globals.Animation:parseSpriteSheet(self.hitSheet, 30, 10)
  print(#self.hitFrames)

  self.states = {
  	MOVING = "moving",
  	HIT = "hit"
  }

  self.x = x
  self.y = y
  self.ox = 0
  self.oy = 0
  self.width = 4
  self.height = 8
  self.speed = 700
  self.state = self.states.MOVING
  self.currentFrame = 1
  self.timer = 0
  return self
end


function Bullet:shoot(x, y, dt)
  cooldownTimer = (cooldownTimer or 0) - dt
  if cooldownTimer <= 0 then
    table.insert(Globals.Bullets, Bullet.new(x, y))
    cooldownTimer = 0.1
  end
end


function Bullet:update(dt)
  if self.state == self.states.MOVING then
	self.y = self.y + self.speed * dt

	if self.y > Globals.Screen.height then
		self:triggerHit()
	end
  elseif self.state == self.states.HIT then
  	self.timer = self.timer + dt
  	if self.timer >= frameDuration then
		self.timer = 0
		if self.currentFrame < #self.hitFrames then
			self.currentFrame = self.currentFrame + 1
		else
			return true
		end
  	end
  end
  return false
end


function Bullet:triggerHit()
  if self.state ~= self.states.HIT then
	self.state = self.states.HIT
	self.timer = 0
	self.currentFrame = 1
  end
end


function Bullet:draw()
  love.graphics.setColor(1, 1, 1)
  if self.state == self.states.MOVING then
	love.graphics.draw(self.sprite, self.x, self.y)
  elseif self.state == self.states.HIT then
  	local index = math.max(1, math.min(self.currentFrame, #self.hitFrames))
  	local quad = self.hitFrames[index]

  	if quad then
		love.graphics.draw(self.hitSheet, quad, self.x - 15, self.y)
	else
		print("Bullet State: "..self.state.." | Index: "..index.." | Table Size: "..#self.hitFrames)
  	end
  end
end

return Bullet
