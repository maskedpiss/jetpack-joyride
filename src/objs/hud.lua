local HUD = {}

function HUD:load()
  self.Score = {
      font = love.graphics.newFont(64),
      x = Globals.Screen.y,
      y = 50
  }
  
  self.Health = {
      x = Globals.Screen.width - 200,
      y = 50,
      radius = 10
  }
end


function HUD:update(dt)
  
end


function HUD:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(self.Score.font)
  love.graphics.printf(Globals.Score.."m", self.Score.x, self.Score.y, Globals.Screen.width, "center")
  
  love.graphics.setColor(1, 0, 0)
  if Globals.playerHealth > 2 then
    love.graphics.circle("fill", self.Health.x, self.Health.y, self.Health.radius)
    love.graphics.circle("fill", self.Health.x + 25, self.Health.y, self.Health.radius)
    love.graphics.circle("fill", self.Health.x + 50, self.Health.y, self.Health.radius)
  elseif Globals.playerHealth > 1 then
    love.graphics.circle("fill", self.Health.x, self.Health.y, self.Health.radius)
    love.graphics.circle("fill", self.Health.x + 25, self.Health.y, self.Health.radius)
  elseif Globals.playerHealth <= 1 then
    love.graphics.circle("fill", self.Health.x, self.Health.y, self.Health.radius)
  end
end

return HUD
