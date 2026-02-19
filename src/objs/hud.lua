local HUD = {}

local timer = 0
local frameDuration = 0.1

function HUD:load()
  self.Score = {
      x = Globals.Screen.x,
      y = 50
  }

  self.states = {
    	FULL = "full",
    	TRANSITION = "transition",
    	EMPTY = "empty"
  }
    
  self.currentState = self.states.FULL
  
  self.Health = {
      sprite = Globals.Graphics.Sprites.Heart,
      x = 50,
      y = 50,
      spacing = 40
  }

  self.hearts = {}
  for i = 1, Globals.maxPlayerHealth do
	self.hearts[i] = {
		state = self.states.FULL,
		currentFrame = 1,
		timer = 0
	}
  end

  self:animateHearts()
end


function HUD:animateHearts()
  local frameWidth = 30
  local frameHeight = frameWidth

  self.healthFrames = Globals.Animation:parseSpriteSheet(self.Health.sprite, frameWidth, frameHeight)
  self.currentFrame = 1
end


function HUD:update(dt)
  for i, heart in ipairs(self.hearts) do
	if Globals.playerHealth < i and heart.state == self.states.FULL then
		heart.state = self.states.TRANSITION
	elseif Globals.playerHealth >= i then
		heart.state = self.states.FULL
		heart.currentFrame = 1
	end

	if heart.state == self.states.TRANSITION then
		heart.timer = heart.timer + dt
		if heart.timer >= frameDuration then
			heart.timer = 0
			heart.currentFrame = heart.currentFrame + 1

			if heart.currentFrame >= 7 then
				heart.state = self.states.EMPTY
				heart.currentFrame = 7
			end
		end
	elseif heart.state == self.states.EMPTY then
		heart.currentFrame = 7
	end
  end
end


function HUD:draw()
  love.graphics.setColor(0, 0, 0)
  love.graphics.setFont(Globals.Graphics.Fonts.ScoreFont)
  love.graphics.printf(Globals.Score.."m", self.Score.x, self.Score.y, Globals.Screen.width, "center")
  
  love.graphics.setColor(1, 1, 1)
  for i = 1, Globals.maxPlayerHealth do
	local drawX = self.Health.x + (i - 1) * self.Health.spacing
	love.graphics.draw(self.Health.sprite, self.healthFrames[7], drawX, self.Health.y)
  end
  
  for i, heart in ipairs(self.hearts) do
	local drawX = self.Health.x + (i - 1) * self.Health.spacing
	love.graphics.draw(self.Health.sprite, self.healthFrames[heart.currentFrame], drawX, self.Health.y)
  end
end

return HUD
