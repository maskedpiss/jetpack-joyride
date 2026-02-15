local Play = {}

Play.Collisions = require("src/utils/collisions")

local world = require("src/objs/gameworld")
local hud = require("src/objs/hud")
local Player = require("src/objs/player")
local Zapper = require("src/objs/obstacles/zapper")
local bullet = require("src/objs/bullet")
local rocket = require("src/objs/obstacles/rocket")

local player = nil
local zapper = nil

function Play.onEnter()
  world:load()
  hud:load()
  
  player = Player.new(150, Globals.Screen.height / 2)
  zapper = Zapper.new()
  
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
    table.insert(Globals.Rockets, rocket.new())
  end
  
  world:update(dt)
  player:update(dt)
  bullet:update(dt)
  zapper:update(dt)
  
  if Play.Collisions:genericAABB(player, world.Ground) then
    player.yVel = 0
    player.y = world.Ground.y - player.height
  end
  
  if love.mouse.isDown(1) then
    bullet:shoot(player.x + player.width / 2, player.y + player.height, dt)
  end
  
  if Play.Collisions:checkHitBox(player, zapper.Laser) then
    if zapper.isPoweredOn then
    	Globals.playerHealth = Globals.playerHealth - 1
    	zapper.hasBeenHit = true
    	zapper.isPoweredOn = false
    end
  end
  
  for i = #Globals.Rockets, 1, -1 do
    local r = Globals.Rockets[i]
    r:update(dt)
    if Play.Collisions:checkHitBox(player, r) then
      Globals.playerHealth = Globals.playerHealth - 1
      table.remove(Globals.Rockets, i)
    end
  end
  
  for i = #Globals.Bullets, 1, -1 do
    local b = Globals.Bullets[i]
    local bulletRemoved = false
    
    if Play.Collisions:genericAABB(b, world.Ground) then
      table.remove(Globals.Bullets, i)
      bulletRemoved = true
    end
    
    if not bulletRemoved then
      for j = #Globals.Rockets, 1, -1 do
        local r = Globals.Rockets[j]
        if Play.Collisions:genericAABB(b, r) then
          r.health = r.health - 1
          table.remove(Globals.Bullets, i)
          if r.health <= 0 then
            table.remove(Globals.Rockets, j)
            Globals.rocketSpawnTimer = math.random(2, 5)
          end
          break
        end
      end
      if Play.Collisions:genericAABB(b, zapper.Generator) or Play.Collisions:genericAABB(b, zapper.genHitBox2) then
	  	zapper.Generator.health = zapper.Generator.health - 1
	  	table.remove(Globals.Bullets, i)
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
  player = nil
  zapper = nil
end

return Play
