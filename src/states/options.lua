local Options = {}

local Buttons = require("src.objs.button")
local Toggles = require("src.objs.toggle")
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
  
  Options.Title = {
  	text = "[OPTIONS]",
  	x = Globals.Screen.x,
  	y = 50
  }

  vsyncToggle = Toggles.new(function()
  	if not vsyncToggle.isToggled then
		vsyncToggle.isToggled = true
		love.window.setVSync(true)
  	else
		vsyncToggle.isToggled = false
		love.window.setVSync(false)
  	end
  end)

  backButton = Buttons.new("Back", Globals.Screen.width / 2, (Globals.Screen.height / 2) + 100, function()
  	  GameState:changeState("menu")
    end)
end


function Options.update(dt)
  Options.BG.x = Options.BG.x - Options.BG.speed * dt

  if Options.BG.x + Options.BG.width < Globals.Screen.x then
	Options.BG.x = Globals.Screen.x
  end

  vsyncToggle:update(dt)
  backButton:update(dt)
end


function Options.mousepressed(x, y, button)
  if backButton:mousepressed(x, y, button) then
	return
  end

  if vsyncToggle:mousepressed(x, y, button) then
	return
  end
end


function Options.mousereleased(x, y, button)
  if backButton:mousereleased(x, y, button) then
	return
  end
end


function Options.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Options.BG.sprite, Options.BG.x, Options.BG.y)
  love.graphics.draw(Options.BG.sprite, Options.BG.x + Options.BG.width, Options.BG.y)

  love.graphics.draw(Globals.Graphics.Sprites.BG2, Globals.Screen.x, Globals.Screen.y)

  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.TitleFont)
  love.graphics.printf(Options.Title.text, Options.Title.x, Options.Title.y, Globals.Screen.width, "center")

  love.graphics.setFont(Globals.Graphics.Fonts.ButtonFont)
  love.graphics.printf("VSync: ", Globals.Screen.x, Globals.Screen.height / 2, Globals.Screen.width, "center")

  vsyncToggle:draw()

  love.graphics.setColor(1, 1, 1)
  backButton:draw()
end


function Options.onExit()

end

return Options
