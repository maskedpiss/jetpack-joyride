local Zapper = require("src.objs.obstacles.zapper")
local ZapperManager = {}

ZapperManager.pool = {}
ZapperManager.poolSize = 5
ZapperManager.spawnDistance = 400

function ZapperManager:load()
	for i = 1, self.poolSize do
		local z = Zapper.new()
		z.Generator.x = Globals.Screen.width + (i * self.spawnDistance)
		table.insert(self.pool, z)
	end
end


function ZapperManager:update(dt)
	for _, z in ipairs(self.pool) do
		z:update(dt)

		local totalWidth = z.orientation == "horizontal" and z.totalWidth or z.Generator.width

		if z.Generator.x + totalWidth < Globals.Screen.x then
			local newX = Globals.Screen.width + math.random(100, 500)
			z:reset()
			z.Generator.x = newX
		end
	end
end


function ZapperManager:draw()
	for _, z in ipairs(self.pool) do
		z:draw()
	end
end

return ZapperManager
