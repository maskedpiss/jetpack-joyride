local HUD = {}

function HUD:load()
  self.Score = {
      font = love.graphics.newFont(64),
      x = Globals.Screen.x,
      y = 50
  }
  
  self.Health = {
      x = 50,
      y = 50,
      radius = 12,
      spacing = 30
  }
end


function HUD:update(dt)
  
end


function HUD:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(self.Score.font)
  love.graphics.printf(Globals.Score.."m", self.Score.x, self.Score.y, Globals.Screen.width, "center")
  
  love.graphics.setColor(1, 0, 0)
  for i = 1, Globals.playerHealth do
    local drawX = self.Health.x + (i - 1) * self.Health.spacing
    love.graphics.circle("fill", drawX, self.Health.y, self.Health.radius)
  end
end

return HUD
