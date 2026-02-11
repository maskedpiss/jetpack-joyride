local GameOver = {}

local titleFont = love.graphics.newFont(128)

function GameOver.onEnter()
  GameOver.Message = {
      text = "Game Over!",
      x = Globals.Screen.x,
      y = 50
  }
end


function GameOver.update(dt)
  
end


function GameOver.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(titleFont)
  love.graphics.printf(GameOver.Message.text, GameOver.Message.x, GameOver.Message.y, Globals.Screen.width, "center")
end


function GameOver.onExit()
  
end

return GameOver
