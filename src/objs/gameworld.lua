local GameWorld = {}

function GameWorld:load()
  self.Sky = {
      sprite = Globals.Graphics.Sprites.BG1,
      x = 0,
      y = 0,
      width = Globals.Graphics.Sprites.BG1:getWidth(),
      speed = 50
  }
  
  self.Ground = {
      x = Globals.Screen.x,
      y = Globals.Screen.height - 100,
      width = Globals.Screen.width,
      height = 100
  }
end


function GameWorld:update(dt)
  self.Sky.x = self.Sky.x - self.Sky.speed * dt
  if self.Sky.x + self.Sky.width < Globals.Screen.x then
    self.Sky.x = Globals.Screen.x
  end
end


function GameWorld:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.Sky.sprite, self.Sky.x, self.Sky.y)
  love.graphics.draw(self.Sky.sprite, self.Sky.x + self.Sky.width, self.Sky.y)
  
  love.graphics.setColor(0.4, 0.67, 0.49)
  love.graphics.rectangle("fill", self.Ground.x, self.Ground.y, self.Ground.width, self.Ground.height)
end

return GameWorld
