function onMoveCamera(focus)
	if focus == 'dad' and dadName == 'r' then
		setProperty('camFollow.x', getMidpointX("dad") + 250)
		setProperty('camFollow.y', getMidpointY("dad") - 100)
	elseif focus == 'dad' and dadName == 'r3' then
		setProperty('camFollow.x', getMidpointX("dad") + 250)
		setProperty('camFollow.y', getMidpointY("dad") - 100)
	elseif focus == 'dad' and dadName == 'acesora' then
		setProperty('camFollow.x', getMidpointX("dad") + 250)
		setProperty('camFollow.y', getMidpointY("dad") + 30)
	end
end