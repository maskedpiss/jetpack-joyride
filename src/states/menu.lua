local Menu = {}

local titleFont = love.graphics.newFont(128)

function Menu.onEnter()
  Menu.Title = {
      text = "Jetpack Joyride",
      x = Globals.Screen.x,
      y = 50
  }
end


function Menu.update(dt)
  
end


function Menu.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(titleFont)
  love.graphics.printf(Menu.Title.text, Menu.Title.x, Menu.Title.y, Globals.Screen.width, "center")
end


function Menu.onExit()
  
end

return Menu
