local Player = {}

local timer = 0
local frameDuration = 0.1

function Player.new(x, y)
  local instance = {}
  setmetatable(instance, { __index = Player })

  instance.sprite = Globals.Graphics.Sprites.Player
  instance.x = x
  instance.y = y
  instance.ox = 6
  instance.oy = 12
  instance.width = 18
  instance.height = 48
  instance.gravity = 1500
  instance.thrust = 2500
  instance.terminalVelocity = 800
  instance.yVel = 0
  instance.isGrounded = false
  instance.isInvincible = false
  instance.invincibleTimer = 0
  instance.invincibleDuration = 1.0

  instance:animate()

  return instance
end


function Player:animate()
  local frameWidth = 30
  local frameHeight = 60

  self.playerFrames = Globals.Animation:parseSpriteSheet(self.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
end


function Player:update(dt)
  if love.mouse.isDown(1) then
    self.yVel = self.yVel - self.thrust * dt
  else
    self.yVel = self.yVel + self.gravity * dt
  end
  
  self.yVel = math.max(-self.terminalVelocity, math.min(self.yVel, self.terminalVelocity))
  self.y = self.y + self.yVel * dt
  
  if self.y + self.oy  < Globals.Screen.y then
    self.yVel = 0
    self.y = Globals.Screen.y - self.oy
  end

  if self.isGrounded then
	timer = timer + dt

	if timer >= frameDuration then
		timer = 0
		self.currentFrame = self.currentFrame + 1
		if self.currentFrame > 4 then
			self.currentFrame = 1
		end
	end
  else
  	self.currentFrame = 5
  end

  if self.isInvincible then
	self.invincibleTimer = self.invincibleTimer - dt
	if self.invincibleTimer <= 0 then
		self.isInvincible = false
		self.invincibleTimer = 0
	end
  end
end


function Player:draw()
  if self.isInvincible then
	if math.fmod(self.invincibleTimer, 0.2) > 0.1 then
		love.graphics.setColor(1, 1, 1, 0.3)
	else
		love.graphics.setColor(1, 1, 1, 1)
	end
  else
	love.graphics.setColor(1, 1, 1, 1)
  end
  
  love.graphics.draw(self.sprite, self.playerFrames[self.currentFrame], self.x, self.y)
  love.graphics.setColor(1, 1, 1, 1)
end

return Player
