Globals = {}

local world = require("src/objs/gameworld")

function love.load()
  Globals.Screen = {
      x = 0,
      y = 0,
      width = love.graphics.getWidth(),
      height = love.graphics.getHeight()
  }
  
  world:load()
end


function love.update(dt)
  
end


function love.draw()
  world:draw()
end
