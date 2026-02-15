local Player = {}

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
	self.currentFrame = 1
  else
  	self.currentFrame = 2
  end
end


function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.sprite, self.playerFrames[self.currentFrame], self.x, self.y)
end

return Player
