local Player = {}

function Player.new(x, y)
  local instance = {}
  setmetatable(instance, { __index = Player })
  
  instance.x = x
  instance.y = y
  instance.width = 20
  instance.height = 40
  instance.gravity = 1500
  instance.yVel = 0
  
  return instance
end


function Player:update(dt)
  if love.mouse.isDown(1) then
    self.yVel = self.yVel - self.gravity * dt
  else
    self.yVel = self.yVel + self.gravity * dt
  end
  
  self.y = self.y + self.yVel * dt
  
  if self.y < Globals.Screen.y then
    self.yVel = 0
    self.y = Globals.Screen.y
  end
end


function Player:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Player
