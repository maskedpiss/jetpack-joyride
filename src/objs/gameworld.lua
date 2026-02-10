local GameWorld = {}

function GameWorld:load()
  self.BG = {
      color = {0, 0, 1}
  }
  
  self.Ground = {
      x = Globals.Screen.x,
      y = Globals.Screen.height - 100,
      width = Globals.Screen.width,
      height = 100
  }
end


function GameWorld:update(dt)
  
end


function GameWorld:draw()
  love.graphics.setBackgroundColor(self.BG.color)
  
  love.graphics.setColor(0.4, 0.67, 0.49)
  love.graphics.rectangle("fill", self.Ground.x, self.Ground.y, self.Ground.width, self.Ground.height)
end

return GameWorld
