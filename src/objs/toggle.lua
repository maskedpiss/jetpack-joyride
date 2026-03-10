local Toggle = {}

local color = { 1, 1, 1 }

function Toggle.new(callback)
	local instance = {}
	setmetatable(instance, { __index = Toggle })

	instance.x = (Globals.Screen.width / 2) + 75
	instance.y = (Globals.Screen.height / 2) + 10
	instance.width = 50
	instance.height = 20
	instance.isToggled = false
	instance.callback = callback or function() end

	return instance
end


function Toggle:update(dt)
	if self.isToggled then
		color = { 0, 1, 0 }
	else
		color = { 1, 1, 1 }
	end

	local _, _, flags = love.window.getMode()
	if flags.vsync == 1 then
		self.isToggled = true
	elseif flags.vsync == 0 then
		self.isToggled = false
	end
end


function Toggle:isHovering(x, y)
	return x > self.x and x < self.x + self.width and
		   y > self.y and y < self.y + self.height
end


function Toggle:mousepressed(x, y, button)
	if self:isHovering(x, y) and button == 1 then
		self:callback()
		return true
	end
	return false
end


function Toggle:draw()
	love.graphics.setColor(color)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Toggle
