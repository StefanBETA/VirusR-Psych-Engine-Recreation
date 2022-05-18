function onUpdate(elapsed)
	if dadName == 'r3' then
		setProperty('dad.y', getProperty('dad.y')-math.sin((curStep*2/20)*2)*2)
	end
end