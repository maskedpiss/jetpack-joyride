local Zapper = require("src.objs.obstacles.zapper")
local ZapperManager = {}

ZapperManager.pool = {}
ZapperManager.poolSize = 4
ZapperManager.spawnDistance = 450

function ZapperManager:load()
	self.pool = {}
	for i = 1, self.poolSize do
		local z = Zapper.new()
		z.x = Globals.Screen.width + (i * self.spawnDistance)
		table.insert(self.pool, z)
	end
end


function ZapperManager:update(dt, player, bullets)
	local max_x = 0

	for _, z in ipairs(self.pool) do
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
			z.x = max_x + self.spawnDistance + math.random(0, 200)
		end
	end
end


function ZapperManager:draw()
	for _, z in ipairs(self.pool) do
		z:draw()
	end
end

return ZapperManager
