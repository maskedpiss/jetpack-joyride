local Graphics = {}

function Graphics:loadFonts()
  self.Fonts = {
      TitleFont = love.graphics.newFont("res/fonts/Carton.ttf", 72),
      ButtonFont = love.graphics.newFont("res/fonts/upheavtt.ttf", 32)
  }
end


function Graphics:loadSprites()
  self.Sprites = {
      BG1 = love.graphics.newImage("res/sprites/BG1.png"),
      BG2 = love.graphics.newImage("res/sprites/BG2.png"),
      TitleCard = love.graphics.newImage("res/sprites/TitleCard.png"),
      EndCard = love.graphics.newImage("res/sprites/GameOverCard.png"),
      Button = love.graphics.newImage("res/sprites/Button.png"),
      Player = love.graphics.newImage("res/sprites/Player.png"),
      Rocket = love.graphics.newImage("res/sprites/Rocket.png"),
      Heart = love.graphics.newImage("res/sprites/Heart.png")
  }
end

return Graphics
