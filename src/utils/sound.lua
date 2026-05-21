local Sound = {}

function Sound:loadSFX()
	self.SFX = {
		Hover = love.audio.newSource("res/sound/ui-game-big-selection-01.wav", "static"),
		ButtonClick1 = love.audio.newSource("res/sound/ui-click-retro-game-click-01.wav", "static"),
		ButtonClick2 = love.audio.newSource("res/sound/ui-click-retro-game-click-03.wav", "static"),
		Switch = love.audio.newSource("res/sound/ui-switch-pull-switch-lamp-01.wav", "static")
	}
end


function Sound:playSound(sound)
	sound:stop()
	love.audio.play(sound)
	Globals.hasPlayed = true
end

return Sound
