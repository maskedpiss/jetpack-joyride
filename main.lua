Globals = {}
Globals.Collisions = require("src/utils/collisions")

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
  
  if Globals.Collisions:AABB(player, world.Ground) then
    player.y = world.Ground.y - player.height
    player.yVel = 0
  end
end


function love.draw()
  world:draw()
  player:draw()
end
