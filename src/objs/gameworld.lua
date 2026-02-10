local GameWorld = {}

function GameWorld:load()
  self.BG = {
      color = {0, 0, 1}
  }
  
  self.Ground = {}
end


function GameWorld:update(dt)
  
end


function GameWorld:draw()
  love.graphics.setBackgroundColor(self.BG.color)
end

return GameWorld
