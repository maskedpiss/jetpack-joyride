local Play = {}

local world = nil

function Play.onEnter()
  world = require("src/objs/gameworld")
  world:load()
end


function Play.update(dt)
  
end


function Play.draw()
  world:draw()
end


function Play.onExit()
  
end

return Play
