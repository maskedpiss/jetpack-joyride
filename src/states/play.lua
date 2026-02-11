local Play = {}

Play.Collisions = require("src/utils/collisions")

local world = nil
local hud = nil
local Player = nil
local player = nil
local Zapper = nil
local zapper = nil
local bullet = nil
local rocket = nil

function Play.onEnter()
  world = require("src/objs/gameworld")
  world:load()
  
  hud = require("src/objs/hud")
  hud:load()
  
  Player = require("src/objs/player")
  player = Player.new(150, Globals.Screen.height / 2)
  
  Zapper = require("src/objs/obstacles/zapper")
  zapper = Zapper.new()
  
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
  zapper:update(dt)
  
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
  
  if Play.Collisions:AABB(player, zapper) then
    Globals.playerHealth = Globals.playerHealth - 1
    zapper:reset()
  end
  
  for i, rocket in ipairs(Globals.Rockets) do
    if Play.Collisions:AABB(rocket, player) then
      Globals.playerHealth = Globals.playerHealth - 1
      player.yVel = 0
      table.remove(Globals.Rockets, i)
    end
  end
  
  for i, bullet in ipairs(Globals.Bullets) do
    if Play.Collisions:AABB(bullet, world.Ground) then
      table.remove(Globals.Bullets, i)
    end
    
    for j, rocket in ipairs(Globals.Rockets) do
      if Play.Collisions:AABB(bullet, rocket) then
        rocket.health = rocket.health - 1
        table.remove(Globals.Bullets, i)
        
        if rocket.health <= 0 then
          table.remove(Globals.Rockets, j)
          Globals.rocketSpawnTimer = math.random(2, 5)
        end
      end
    end
  end
  
  if Globals.playerHealth <= 0 then
    GameState:changeState("gameOver")
  end
end


function Play.draw()
  world:draw()
  player:draw()
  bullet:draw()
  hud:draw()
  zapper:draw()
  
  for i, rocket in ipairs(Globals.Rockets) do
    rocket:draw()
  end
end


function Play.onExit()
  Globals.Bullets = {}
  Globals.Rockets = {}
  world = nil
  hud = nil
  Player = nil
  player = nil
  bullet = nil
  rocket = nil
end

return Play
