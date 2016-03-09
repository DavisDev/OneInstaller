grafics = {}
function grafics.multi_rect(num,x,y,w,h,s,c)
	local i = 1
	while i<=num  do
		draw.fillrect(x,y,w,h,c)
		y = y+h+s
		i = i + 1
	end
end
function grafics.selectrect(x,y,w,h,c)
draw.fillrect(x,y,w,5,c)
draw.fillrect(x,y+h-5,w,5,c)
draw.fillrect(x,y,5,h,c)
draw.fillrect(w+x-5,y,5,h,c)
--draw.fillrect(x+w-2,y,x+w,h,c)
end
function grafics.circle(x,y,r,color)
  local x0, y0 = r, 0
  for i=0,90,9 do
     local x1,y1 = r*math.cos( math.rad( i )), r*math.sin(math.rad( i ));
     draw.line(x+x1,y+y1,x+x0,y+y0,color);
     draw.line(x+x0,y-y0,x+x1,y-y1,color);
     draw.line(x-x0,y+y0,x-x1,y+y1,color);
     draw.line(x-x0,y-y0,x-x1,y-y1,color);
     x0, y0 = x1, y1;
  end
end
function grafics.debug()
local x = 20
local y = 20
while x <= 480 do

draw.line(x,0,x,272,color.new(0,255,0))
screen.print(x,4,x,0.5,color.white,color.black,512)
x = x + 20
end
while y <= 272 do

draw.line(0,y,480,y,color.new(255,0,0))
screen.print(2,y-6,y,0.5,color.white,color.black)
y = y + 20
end
end

function grafics.loadbar(x,y,w,h,porcent,bordcol,barcolor)
	draw.rect(x,y,w,h,bordcol)
	draw.fillrect(x+2,y+2,porcent,h-4,barcolor)
end