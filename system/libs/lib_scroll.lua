--[[
Libreria Scroll
Ideada principalmente en facilitar el manejo de un scroll
Para la utilizacion del metodo:
for i=ini,lim do
	if i=sel then
	else
	end
end
]]
scroll = {}
function scroll.set(num,tab,mxn)
	scroll[num] = {ini=1,sel=1,lim=1,maxim=1}
	if #tab > mxn then scroll[num].lim=mxn else scroll[num].lim=#tab end
	scroll[num].maxim = #tab
end
function scroll.max(num,mx)
scroll[num].maxim = #mx
end
function scroll.up(num)
	if scroll[num].sel>scroll[num].ini then scroll[num].sel=scroll[num].sel-1
	elseif scroll[num].ini-1>=1 then
		scroll[num].ini,scroll[num].sel,scroll[num].lim=scroll[num].ini-1,scroll[num].sel-1,scroll[num].lim-1
	end
end
function scroll.down(num)
	if scroll[num].sel<scroll[num].lim then scroll[num].sel=scroll[num].sel+1
	elseif scroll[num].lim+1<=scroll[num].maxim then
		scroll[num].ini,scroll[num].sel,scroll[num].lim=scroll[num].ini+1,scroll[num].sel+1,scroll[num].lim+1
	end
end
function scroll.print(num,x,y,h,tabla,color1,color2,tam)--Funcion de prueba
	scroll[num].y = y
	for i=scroll[num].ini,scroll[num].lim do 
		if i==scroll[num].sel then
			screen.print(x,scroll[num].y,tabla[i],tam,color1)
		else
			screen.print(x,scroll[num].y,tabla[i],tam,color2)
		end
		scroll[num].y = scroll[num].y + h
	end
end