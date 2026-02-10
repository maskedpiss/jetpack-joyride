local HUD = {}

function HUD:load()
  self.Score = {
      font = love.graphics.newFont(64),
      text = Globals.Score,
      x = Globals.Screen.y,
      y = 50
  }
  
  self.Health = {}
end


function HUD:update(dt)
  
end


function HUD:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(self.Score.font)
  love.graphics.printf(self.Score.text.."m", self.Score.x, self.Score.y, Globals.Screen.width, "center")
end

return HUD
