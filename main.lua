Globals = {}
Globals.Collisions = require("src/utils/collisions")
Globals.Bullets = {}
Globals.Score = 0
Globals.Timer = 0

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
  
  rocket = Rocket.new()
end


function love.update(dt)
  Globals.Timer = Globals.Timer + dt
  if Globals.Timer >= 1 then
    Globals.Score = Globals.Score + 5
    Globals.Timer = Globals.Timer - 1
  end
  
  player:update(dt)
  Bullet:update(dt)
  rocket:update(dt)
  
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
  rocket:draw()
end
