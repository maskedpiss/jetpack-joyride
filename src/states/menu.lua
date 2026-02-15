local Menu = {}

local Buttons = nil
local playButton = nil
local exitButton = nil

function Menu.onEnter()
  Menu.BG = {
      sprite = Globals.Graphics.Sprites.BG1,
      x = Globals.Screen.x,
      y = Globals.Screen.y,
      width = Globals.Graphics.Sprites.BG1:getWidth(),
      height = Globals.Graphics.Sprites.BG1:getHeight(),
      speed = 50
  }
  
  Menu.Title = {
      text = "[PROPULSIONµTEST]",
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
  Menu.BG.x = Menu.BG.x - Menu.BG.speed * dt
  
  if Menu.BG.x + Menu.BG.width < Globals.Screen.x then
    Menu.BG.x = Globals.Screen.x
  end
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
  
  love.graphics.draw(Menu.BG.sprite, Menu.BG.x, Menu.BG.y)
  love.graphics.draw(Menu.BG.sprite, Menu.BG.x + Menu.BG.width, Menu.BG.y)
  love.graphics.draw(Globals.Graphics.Sprites.BG2, Globals.Screen.x, Globals.Screen.y)
  
  love.graphics.draw(Globals.Graphics.Sprites.TitleCard, Menu.Title.x + 6, Menu.Title.y - 6)
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.TitleFont)
  love.graphics.printf(Menu.Title.text, Menu.Title.x, Menu.Title.y, Globals.Screen.width, "center")
  
  playButton:draw()
  exitButton:draw()
end


function Menu.onExit()
  Menu.BG = {}
  Menu.Title = {}
  Buttons = nil
  playButton = nil
  exitButton = nil
end

return Menu
