local Options = {}

local vsyncToggle = nil
local backButton = nil

function Options.onEnter()
  Options.BG = {
  	sprite = Globals.Graphics.Sprites.BG1,
  	x = Globals.Screen.x,
  	y = Globals.Screen.y,
  	width = Globals.Graphics.Sprites.BG1:getWidth(),
  	height = Globals.Graphics.Sprites.BG1:getHeight(),
  	speed = 50
  }
  
  Options.Title = {}
end


function Options.update(dt)

end


function Options.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Options.BG.sprite, Options.BG.x, Options.BG.y)
end


function Options.onExit()

end

return Options
