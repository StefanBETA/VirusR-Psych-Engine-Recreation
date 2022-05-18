function onCreate()
	-- background shit
	makeAnimatedLuaSprite('cyberwall', 'stage/cyber/wall', -557, -298)
	addAnimationByPrefix('cyberwall', 'idle', 'wall', 24)
	objectPlayAnimation('cyberwall', 'idle')
	setScrollFactor('cyberwall', 0.8, 0.8)
	addLuaSprite('cyberwall', false)

	makeLuaSprite('floor', 'stage/cyber/floor', -17, 726)
	addLuaSprite('floor', false)

	makeLuaSprite('tv', 'stage/cyber/TV', 237, 253)
	addLuaSprite('tv', false)

	makeAnimatedLuaSprite('tvL', 'stage/cyber/TV left', -583, -20)
	addAnimationByPrefix('tvL', 'idle', 'TV left', 24)
	objectPlayAnimation('tvL', 'idle')
	addLuaSprite('tvL', false)

	makeAnimatedLuaSprite('tvR', 'stage/cyber/TV right', 1238, -67)
	addAnimationByPrefix('tvR', 'idle', 'TV right', 24)
	objectPlayAnimation('tvR', 'idle')
	addLuaSprite('tvR', false)

	makeLuaSprite('screen', 'stage/cyber/Screen', -603, -265)
	setScrollFactor('screen', 1.2, 1.2)
	addLuaSprite('screen', true)

	makeLuaSprite('line', 'stage/cyber/line', -603, -265)
	setScrollFactor('line', 1.2, 1.2)
	addLuaSprite('line', true)
end

function onMoveCamera(focus)
	if focus == 'boyfriend' then
		setProperty('camFollow.y', getMidpointY("boyfriend") - 170)
	end
end

function onBeatHit()
	objectPlayAnimation('mute', 'idle', true)

	if songName == 'Invade' and dadName == 'r' then
		if curBeat == 226 then
			characterPlayAnim('dad', 'angry')
		end
	end
end