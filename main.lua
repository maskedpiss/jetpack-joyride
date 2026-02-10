Globals = {}

local world = require("src/objs/gameworld")
local Player = require("src/objs/player")
local player = nil

function love.load()
  Globals.Screen = {
      x = 0,
      y = 0,
      width = love.graphics.getWidth(),
      height = love.graphics.getHeight()
  }
  
  world:load()
  player = Player.new(150, Globals.Screen.height / 2)
end


function love.update(dt)
  player:update(dt)
end


function love.draw()
  world:draw()
  player:draw()
end
