local Play = {}

Play.Collisions = require("src.utils.collisions")

local world = require("src.objs.gameworld")
local hud = require("src.objs.hud")
local Player = require("src.objs.player")
local ZapperManager = require("src.utils.zappermanager")
local bullet = require("src.objs.bullet")
local rocket = require("src.objs.obstacles.rocket")

local player = nil
local zapper = nil

function Play.onEnter()
  world:load()
  hud:load()
  
  player = Player.new(250, Globals.Screen.height / 2)
  ZapperManager:load()
  
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
  ZapperManager:update(dt)
  hud:update(dt)
  
  if Play.Collisions:genericAABB(player, world.Ground) then
    player.yVel = 0
    player.y = world.Ground.y - player.height
    player.isGrounded = true
  else
  	player.isGrounded = false
  end
  
  if love.mouse.isDown(1) then
    bullet:shoot(player.x + player.width - 2, player.y + player.height + 12, dt)
  end
  
  for _, z in ipairs(ZapperManager.pool) do
	if z.isPoweredOn and not z.hasBeenHit then
		if Play.Collisions:checkHitBox(player, z.Laser) then
			Globals.playerHealth = Globals.playerHealth - 1
			z.hasBeenHit = true
			z.isPoweredOn = false
		end
	end
  end
  
  for i = #Globals.Rockets, 1, -1 do
    local r = Globals.Rockets[i]
    local shouldRemove = r:update(dt)

    if shouldRemove then
		table.remove(Globals.Rockets, i)
		Globals.rocketSpawnTimer = math.random(2, 5)
    end

    if r.state == r.states.HOMING then
		r.indicator.y = player.y
    end

    if r.state ~= r.states.EXPLODING then
    	if Play.Collisions:checkHitBox(player, r) then
      		Globals.playerHealth = Globals.playerHealth - 1
      		r.state = r.states.EXPLODING
    	end
    end
  end
  
  for i = #Globals.Bullets, 1, -1 do
    local b = Globals.Bullets[i]
    local bulletRemoved = false
    local shouldRemove = b:update(dt)

    if shouldRemove then
		table.remove(Globals.Bullets, i)
    end

    if Play.Collisions:genericAABB(b, world.Ground) then
		b:triggerHit()
    end

	if b.state ~= b.states.HIT then
		for _, z in pairs(ZapperManager.pool) do
	    	if Play.Collisions:genericAABB(b, z.Generator) or Play.Collisions:genericAABB(b, z.genHitBox2) then
				b:triggerHit()
				z.Generator.health = z.Generator.health - 1

				if z.Generator.health <= 0 then
					z.hasBeenHit = true
				end
	    	end
	    end

	    for j = #Globals.Rockets, 1, -1 do
			local r = Globals.Rockets[j]
			
			if Play.Collisions:checkHitBox(b, r) then
				r.health = r.health - 1
				b:triggerHit()
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
  hud:draw()
  ZapperManager:draw()
  
  for i, rocket in ipairs(Globals.Rockets) do
    rocket:draw()
  end

  for i, bullet in ipairs(Globals.Bullets) do
	bullet:draw()
  end
end


function Play.onExit()
  Globals.Bullets = {}
  Globals.Rockets = {}
  player = nil
  zapper = nil
end

return Play
