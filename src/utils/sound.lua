local Sound = {}

function Sound:loadSFX()
	self.SFX = {
		Hover = love.audio.newSource("res/sound/ui-game-big-selection-01.wav", "static"),
		ButtonClick1 = love.audio.newSource("res/sound/ui-click-retro-game-click-01.wav", "static"),
		ButtonClick2 = love.audio.newSource("res/sound/ui-click-retro-game-click-03.wav", "static"),
		Switch = love.audio.newSource("res/sound/ui-switch-pull-switch-lamp-01.wav", "static"),
		Footsteps = love.audio.newSource("res/sound/footsteps.wav", "static"),
		Shooting = love.audio.newSource("res/sound/Shooting.wav", "static"),
		BulletImpact = love.audio.newSource("res/sound/hit-impact.ogg", "static"),
		LaserEngage = love.audio.newSource("res/sound/laser-engage.wav", "static"),
		LaserDisengage = love.audio.newSource("res/sound/laser-disengage.wav", "static"),
		LaserHum = love.audio.newSource("res/sound/laser-hum.wav", "static"),
		RocketLock = love.audio.newSource("res/sound/missile-lockon.mp3", "static"),
		RocketLaunch = love.audio.newSource("res/sound/missile-firing.wav", "static"),
		RocketExplode = love.audio.newSource("res/sound/missile-explode.wav", "static"),
		SmallExplosion = love.audio.newSource("res/sound/small-explosion.mp3", "static")
	}

	self.SFX.Footsteps:setLooping(true)
	self.SFX.Shooting:setLooping(true)
end


function Sound:playSound(sound)
	sound:stop()
	love.audio.play(sound)
	Globals.hasPlayed = true
end

return Sound
