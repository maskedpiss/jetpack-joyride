local Animation = {}

function parseSpriteSheet(texture, frameWidth, frameHeight)
  local sheetWidth, sheetHeight = texture:getDimensions()
  local quads = {}
  local counter = 1

  for y = 0, sheetHeight - 1, frameHeight do
	for x = 0, sheetWidth - 1, frameWidth do
		quads[counter] = love.graphics.newQuad(x, y, frameWidth, frameHeight, sheetWidth, sheetHeight)
		counter = counter + 1
	end
  end
end

return Animation
