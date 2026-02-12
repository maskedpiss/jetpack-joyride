local Graphics = {}

function Graphics:loadFonts()
  self.Fonts = {
      TitleFont = love.graphics.newFont("res/fonts/Carton.ttf", 72)
  }
end

return Graphics
