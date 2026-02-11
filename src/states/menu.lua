local Menu = {}

local titleFont = love.graphics.newFont(128)

local Buttons = nil
local playButton = nil
local exitButton = nil

function Menu.onEnter()
  Menu.Title = {
      text = "Jetpack Joyride",
      x = Globals.Screen.x,
      y = 50
  }
  
  Buttons = require("src/objs/button")
  playButton = Buttons.new("Play", Globals.Screen.width / 2, Globals.Screen.height / 2, function()
      GameState:changeState("play")
    end)
  
  exitButton = Buttons.new("Exit", Globals.Screen.width / 2, (Globals.Screen.height / 2) + 100, function()
      love.event.quit()
    end)
end


function Menu.update(dt)
  
end


function Menu.mousepressed(x, y, button)
  if playButton:mousepressed(x, y, button) then
    return
  end
  
  if exitButton:mousepressed(x, y, button) then
    return
  end
end


function Menu.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(titleFont)
  love.graphics.printf(Menu.Title.text, Menu.Title.x, Menu.Title.y, Globals.Screen.width, "center")
  
  playButton:draw()
  exitButton:draw()
end


function Menu.onExit()
  
end

return Menu
