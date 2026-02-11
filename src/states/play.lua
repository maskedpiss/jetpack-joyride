local Play = {}

Play.Collisions = require("src/utils/collisions")

local world = nil
local hud = nil
local Player = nil
local player = nil
local bullet = nil
local rocket = nil

function Play.onEnter()
  world = require("src/objs/gameworld")
  world:load()
  
  hud = require("src/objs/hud")
  hud:load()
  
  Player = require("src/objs/player")
  player = Player.new(150, Globals.Screen.height / 2)
  
  bullet = require("src/objs/bullet")
  rocket = require("src/objs/obstacles/rocket")
  
  Globals.rocketSpawnTimer = math.random(2, 5)
end


function Play.update(dt)
  Globals.scoreTimer = Globals.scoreTimer + dt
  if Globals.scoreTimer >= 1 then
    Globals.Score = Globals.Score + 5
    Globals.scoreTimer = 0
  end
  
  Globals.rocketSpawnTimer = Globals.rocketSpawnTimer - dt
  if Globals.rocketSpawnTimer <= 0 and #Globals.Rockets == 0 then
    local newRocket = rocket.new()
    table.insert(Globals.Rockets, newRocket)
  end
  
  player:update(dt)
  bullet:update(dt)
  
  for i, rocket in ipairs(Globals.Rockets) do
    rocket:update(dt)
  end
  
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
  
  for i, rocket in ipairs(Globals.Rockets) do
    rocket:draw()
  end
end


function Play.onExit()
  
end

return Play
