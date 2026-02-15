local GameOver = {}

local Buttons = require("src/objs/button")

local retryButton = nil
local exitButton = nil

function GameOver.onEnter()
  GameOver.BG = {
      sprite = Globals.Graphics.Sprites.BG1,
      x = 0,
      y = 0,
      width = Globals.Graphics.Sprites.BG1:getWidth(),
      speed = 50
  }
  
  GameOver.Message = {
      text = "[GAMEµOVER!]",
      x = Globals.Screen.x,
      y = 50
  }
  
  retryButton = Buttons.new("Retry", Globals.Screen.width / 2, Globals.Screen.height / 2, function()
      GameState:changeState("play")
    end)
  
  exitButton = Buttons.new("Exit", Globals.Screen.width / 2, (Globals.Screen.height / 2) + 100, function()
      love.event.quit()
    end)
end


function GameOver.update(dt)
  GameOver.BG.x = GameOver.BG.x - GameOver.BG.speed * dt
  if GameOver.BG.x + GameOver.BG.width < Globals.Screen.x then
    GameOver.BG.x = Globals.Screen.x
  end
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
  love.graphics.draw(GameOver.BG.sprite, GameOver.BG.x, GameOver.BG.y)
  love.graphics.draw(GameOver.BG.sprite, GameOver.BG.x + GameOver.BG.width, GameOver.BG.y)
  love.graphics.draw(Globals.Graphics.Sprites.BG2, Globals.Screen.x, Globals.Screen.y)
  
  love.graphics.draw(Globals.Graphics.Sprites.EndCard, GameOver.Message.x + 6, GameOver.Message.y - 6)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.TitleFont)
  love.graphics.printf(GameOver.Message.text, GameOver.Message.x, GameOver.Message.y, Globals.Screen.width, "center")
  
  retryButton:draw()
  exitButton:draw()
end


function GameOver.onExit()
  GameOver.Message = {}
  retryButton = nil
  exitButton = nil
  Globals.Score = 0
  Globals.playerHealth = 3
end

return GameOver
