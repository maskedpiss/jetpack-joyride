local Graphics = {}

function Graphics:loadFonts()
  self.Fonts = {
      TitleFont = love.graphics.newFont("res/fonts/Carton.ttf", 128)
  }
end

return Graphics
