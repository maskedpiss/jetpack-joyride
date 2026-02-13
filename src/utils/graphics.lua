local Graphics = {}

function Graphics:loadFonts()
  self.Fonts = {
      TitleFont = love.graphics.newFont("res/fonts/Carton.ttf", 72)
  }
end


function Graphics:loadSprites()
  self.Sprites = {
      BG1 = love.graphics.newImage("res/sprites/BG1.png"),
      BG2 = love.graphics.newImage("res/sprites/BG2.png"),
      TitleCard = love.graphics.newImage("res/sprites/TitleCard.png")
  }
end

return Graphics
