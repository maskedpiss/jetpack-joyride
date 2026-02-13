local GameWorld = {}

function GameWorld:load()
  self.Sky = {
      sprite = Globals.Graphics.Sprites.BG1,
      x = 0,
      y = 0,
      width = Globals.Graphics.Sprites.BG1:getWidth(),
      speed = 50
  }
  
  self.Hallway = {
      sprite = Globals.Graphics.Sprites.BG2,
      x = 0,
      y = 0,
      width = Globals.Graphics.Sprites.BG2:getWidth(),
      speed = 150
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
  
  self.Hallway.x = self.Hallway.x - self.Hallway.speed * dt
  if self.Hallway.x + self.Hallway.width < Globals.Screen.x then
    self.Hallway.x = Globals.Screen.x
  end
end


function GameWorld:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.Sky.sprite, self.Sky.x, self.Sky.y)
  love.graphics.draw(self.Sky.sprite, self.Sky.x + self.Sky.width, self.Sky.y)
  
  love.graphics.draw(self.Hallway.sprite, self.Hallway.x, self.Hallway.y)
  love.graphics.draw(self.Hallway.sprite, self.Hallway.x + self.Hallway.width, self.Hallway.y)
end

return GameWorld
