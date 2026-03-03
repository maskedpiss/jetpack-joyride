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
  Options.BG.x = Options.BG.x - Options.BG.speed * dt

  if Options.BG.x + Options.BG.width < Globals.Screen.x then
	Options.BG.x = Globals.Screen.x
  end
end


function Options.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Options.BG.sprite, Options.BG.x, Options.BG.y)
  love.graphics.draw(Options.BG.sprite, Options.BG.x + Options.BG.width, Options.BG.y)
end


function Options.onExit()

end

return Options
