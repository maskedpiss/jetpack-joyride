Globals = {}
Globals.Collisions = require("src/utils/collisions")
Globals.Bullets = {}

local world = require("src/objs/gameworld")
local Player = require("src/objs/player")
local Bullet = require("src/objs/bullet")
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
  Bullet:update(dt)
  
  if Globals.Collisions:AABB(player, world.Ground) then
    player.y = world.Ground.y - player.height
    player.yVel = 0
  end
  
  if love.mouse.isDown(1) then
    if #Globals.Bullets < 10 then
      Bullet:shoot(player.x + player.width / 2, player.y + player.height)
    end
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
  player:draw()
  Bullet:draw()
end
