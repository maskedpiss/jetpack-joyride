local Zapper = require("src.objs.obstacles.zapper")
local ZapperManager = {}

ZapperManager.pool = {}
ZapperManager.poolSize = 4
ZapperManager.spawnDistance = 450
ZapperManager.elapsedTime = 0
ZapperManager.difficultyScale = 0.05
ZapperManager.baseSpeed = 150
ZapperManager.maxSpeed = 600
ZapperManager.currentSpeed = 150

function ZapperManager:load()
	self.pool = {}
	for i = 1, self.poolSize do
		local z = Zapper.new()
		z.x = Globals.Screen.width + (i * self.spawnDistance)
		table.insert(self.pool, z)
	end
end


function ZapperManager:resetDifficulty()
	self.elapsedTime = 0
	self.currentSpeed = self.baseSpeed

	for _, z in ipairs(self.pool) do
		z:reset()
		z.speed = self.baseSpeed
	end
end


function ZapperManager:update(dt, player, bullets)
	local max_x = 0
	local gapReduction = math.min(150, self.elapsedTime * 0.1)
	local currentMinDistance = self.spawnDistance - gapReduction

	self.elapsedTime = self.elapsedTime + dt
	self.currentSpeed = math.min(self.maxSpeed, self.baseSpeed + (self.elapsedTime * self.difficultyScale))
	print(self.currentSpeed)

	for _, z in ipairs(self.pool) do
		z.speed = self.currentSpeed
		z:update(dt)

		if z:checkCollision(player) then
			if not z.hasHitPlayer then
				Globals.playerHealth = Globals.playerHealth - 1
				z.hasHitPlayer = true
			end
		end

		if bullets then
			for i = #bullets, 1, -1 do
				if z:checkBulletCollision(bullets[i]) then
					table.remove(bullets, i)
				end
			end
		end

		if z.x > max_x then
			max_x = z.x
		end
	end

	for _, z in ipairs(self.pool) do
		local fullWidth = (z.orientation == "horizontal") and 320 or 60
		if z.x + fullWidth < 0 then
			z:reset()
			z.x = max_x + currentMinDistance + math.random(0, 200)
		end
	end
end


function ZapperManager:draw()
	for _, z in ipairs(self.pool) do
		z:draw()
	end
end

return ZapperManager
