Globals = {}
Globals.Collisions = require("src/utils/collisions")
Globals.Bullets = {}
Globals.Rockets = {}
Globals.Score = 0
Globals.scoreTimer = 0
Globals.rocketSpawnTimer = 0

local world = require("src/objs/gameworld")
local Player = require("src/objs/player")
local Bullet = require("src/objs/bullet")
local hud = require("src/objs/hud")
local Rocket = require("src/objs/obstacles/rocket")
local player = nil
local rocket = nil

function love.load()
  Globals.Screen = {
      x = 0,
      y = 0,
      width = love.graphics.getWidth(),
      height = love.graphics.getHeight()
  }
  
  world:load()
  hud:load()
  player = Player.new(150, Globals.Screen.height / 2)
  
  Globals.rocketSpawnTimer = math.random(2, 5)
end


function love.update(dt)
  Globals.scoreTimer = Globals.scoreTimer + dt
  if Globals.scoreTimer >= 1 then
    Globals.Score = Globals.Score + 5
    Globals.scoreTimer = Globals.scoreTimer - 1
  end
  
  Globals.rocketSpawnTimer = Globals.rocketSpawnTimer - dt
  if Globals.rocketSpawnTimer <= 0 and #Globals.Rockets == 0 then
    rocket = Rocket.new()
    table.insert(Globals.Rockets, rocket)
  end
  
  player:update(dt)
  Bullet:update(dt)
  
  for i, rocket in ipairs(Globals.Rockets) do
    rocket:update(dt)
  end
  
  if #Globals.Rockets > 0 then
    rocket:update(dt)
  end
  
  if Globals.Collisions:AABB(player, world.Ground) then
    player.y = world.Ground.y - player.height
    player.yVel = 0
  end
  
  if love.mouse.isDown(1) then
    Bullet:shoot(player.x + player.width / 2, player.y + player.height)
  end
  
  for i, bullet in ipairs(Globals.Bullets) do
    if Globals.Collisions:AABB(bullet, world.Ground) then
      bullet.y = world.Ground.y - bullet.height
      table.remove(Globals.Bullets, i)
    end
  end
end


function love.draw()
  world:draw()
  hud:draw()
  player:draw()
  Bullet:draw()
  
  for i, rocket in ipairs(Globals.Rockets) do
    rocket:draw()
  end
end
