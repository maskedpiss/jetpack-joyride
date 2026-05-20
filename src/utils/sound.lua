local Sound = {}

function Sound:loadSFX()
	self.SFX = {
		Hover = love.audio.newSource("res/sound/ui-game-big-selection-01.wav", "static")
	}
end


function Sound:playSound(sound)
	sound:stop()
	love.audio.play(sound)
	Globals.hasPlayed = true
end

return Sound
