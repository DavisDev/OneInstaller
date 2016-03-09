WAVE = {}

function WAVE.init(path)
	WAVE.y = 0
	WAVE.x = 0
	if path then
		WAVE.IMG = image.load(path)
	end
end

function WAVE.blit(vel,trans)
	if trans == nil then trans = 255 else trans = 255 end
	if vel == nil then vel = 2 end	
	if WAVE.x < -480 then WAVE.x = WAVE.x + 480 end
	WAVE.x = WAVE.x - vel
	local x = WAVE.x
	local y = WAVE.y
	if x <= -480 then WAVE.x = 0 end
	WAVE.IMG:blit(x,y,trans)
	WAVE.IMG:blit(x + 480,y,trans)
end
