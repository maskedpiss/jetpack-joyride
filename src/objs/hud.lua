local HUD = {}

function HUD:load()
  self.Score = {
      x = Globals.Screen.x,
      y = 50
  }
  
  self.Health = {
      sprite = Globals.Graphics.Sprites.Heart,
      x = 50,
      y = 50,
      spacing = 40
  }

  self:animateHearts()
end


function HUD:animateHearts()
  local frameWidth = 30
  local frameHeight = frameWidth

  self.healthFrames = Globals.Animation:parseSpriteSheet(self.Health.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
end


function HUD:update(dt)
  
end


function HUD:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.ScoreFont)
  love.graphics.printf(Globals.Score.."m", self.Score.x, self.Score.y, Globals.Screen.width, "center")
  
  love.graphics.setColor(1, 1, 1)
  for i = 1, Globals.maxPlayerHealth do
	local drawX = self.Health.x + (i - 1) * self.Health.spacing
	love.graphics.draw(self.Health.sprite, self.healthFrames[2], drawX, self.Health.y)
  end
  
  for i = 1, Globals.playerHealth do
    local drawX = self.Health.x + (i - 1) * self.Health.spacing
    love.graphics.draw(self.Health.sprite, self.healthFrames[self.currentFrame], drawX, self.Health.y)
  end
end

return HUD
