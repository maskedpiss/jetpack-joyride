local GameOver = {}

local titleFont = love.graphics.newFont(128)

local Buttons = nil
local retryButton = nil
local exitButton = nil

function GameOver.onEnter()
  GameOver.Message = {
      text = "Game Over!",
      x = Globals.Screen.x,
      y = 50
  }
  
  Buttons = require("src/objs/button")
  retryButton = Buttons.new("Retry", Globals.Screen.width / 2, Globals.Screen.height / 2, function()
      GameState:changeState("play")
    end)
  
  exitButton = Buttons.new("Exit", Globals.Screen.width / 2, (Globals.Screen.height / 2) + 100, function()
      love.event.quit()
    end)
end


function GameOver.update(dt)
  
end


function GameOver.mousepressed(x, y, button)
  if retryButton:mousepressed(x, y, button) then
    return
  end
  
  if exitButton:mousepressed(x, y, button) then
    return
  end
end


function GameOver.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(titleFont)
  love.graphics.printf(GameOver.Message.text, GameOver.Message.x, GameOver.Message.y, Globals.Screen.width, "center")
  
  retryButton:draw()
  exitButton:draw()
end


function GameOver.onExit()
  
end

return GameOver
