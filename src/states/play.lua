local Play = {}

Play.Collisions = require("src/utils/collisions")

local world = nil
local hud = nil
local Player = nil
local player = nil
local bullet = nil

function Play.onEnter()
  world = require("src/objs/gameworld")
  world:load()
  
  hud = require("src/objs/hud")
  hud:load()
  
  Player = require("src/objs/player")
  player = Player.new(150, Globals.Screen.height / 2)
  
  bullet = require("src/objs/bullet")
end


function Play.update(dt)
  player:update(dt)
  bullet:update(dt)
  
  if Play.Collisions:AABB(player, world.Ground) then
    player.yVel = 0
    player.y = world.Ground.y - player.height
  end
  
  if love.mouse.isDown(1) then
    bullet:shoot(player.x + player.width / 2, player.y + player.height)
  end
  
  for i, bullet in ipairs(Globals.Bullets) do
    if Play.Collisions:AABB(bullet, world.Ground) then
      table.remove(Globals.Bullets, i)
    end
  end
end


function Play.draw()
  world:draw()
  player:draw()
  bullet:draw()
  hud:draw()
end


function Play.onExit()
  
end

return Play
