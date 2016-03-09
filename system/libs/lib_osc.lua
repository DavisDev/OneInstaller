osc = {}
function osc.init(ini,lim,var)
	osc.Dini = ini
	osc.Dlim = lim
	osc.Dvar = var
	osc.Dresult = ini
	osc.up = true
end 
function osc.run()
	if osc.Dresult <= osc.Dlim and osc.up then
		osc.Dresult = osc.Dresult + osc.Dvar
	else
		osc.up = false
	end
	if osc.Dresult >= osc.Dini and (not osc.up) then
			osc.Dresult = osc.Dresult - osc.Dvar
	else
		osc.up = true
	end
end
function osc.get()
	return osc.Dresult
end
function osc.defmin()
	osc.Dresult = osc.Dini
end
function osc.defmax()
	osc.Dresult = osc.Dlim
end