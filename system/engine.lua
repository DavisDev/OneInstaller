--files.encrypt("system/libs/lib_wave.lua")
--files.desencrypt("system/configs/hosting.ini")
-- ## Recursos A Cargar ##
icon = {
	-- ## Logos ##
	one = kernel.loadimage("system/theme/one_ico.png"),
	-- ## Barra Superior ##
	wifi = image.load("system/theme/wifi.png",14,11),
	ms = kernel.loadimage("system/theme/ms.png"),
	cats = { -- ## Categorias ##
		kernel.loadimage("system/theme/cats/1.png"),
		kernel.loadimage("system/theme/cats/2.png"),
		kernel.loadimage("system/theme/cats/3.png"),
		kernel.loadimage("system/theme/cats/4.png"),
		kernel.loadimage("system/theme/cats/5.png"),
		kernel.loadimage("system/theme/cats/6.png"),
		kernel.loadimage("system/theme/cats/7.png"),
		kernel.loadimage("system/theme/cats/8.png")
	},
	stars = kernel.loadimage("system/theme/stars.png",105,20),
	flags = { -- ## Banderas Visor ##
		cats = kernel.loadimage("system/theme/flags/cats.png",27,12),
		model = kernel.loadimage("system/theme/flags/model.png",27,12),
		lang = kernel.loadimage("system/theme/flags/lang.png",21,12)
	},
	-- ## Indicadores laterales Visor ##
	dl = kernel.loadimage("system/theme/dl.png"),
	wn = kernel.loadimage("system/theme/wn.png"),
	ss = kernel.loadimage("system/theme/ss.png"),
	-- ## Def Icon´s 0 ##
	prx = {
		kernel.loadimage("system/theme/icon0/prx_1.png"),
		kernel.loadimage("system/theme/icon0/prx_2.png"),
		kernel.loadimage("system/theme/icon0/prx_3.png"),
		kernel.loadimage("system/theme/icon0/prx_4.png"),
	},
	hb = {
		kernel.loadimage("system/theme/icon0/hb_1.png"),
		kernel.loadimage("system/theme/icon0/hb_2.png"),
		kernel.loadimage("system/theme/icon0/hb_3.png"),
		kernel.loadimage("system/theme/icon0/hb_4.png"),
	},
	ud = {
		kernel.loadimage("system/theme/icon0/update_1.png"),
		kernel.loadimage("system/theme/icon0/update_2.png"),
		kernel.loadimage("system/theme/icon0/update_3.png"),
	},
	-- ## ##
	fb = kernel.loadimage("system/theme/fb.png"),
	fi = kernel.loadimage("system/theme/fi.png"),
	ur = kernel.loadimage("system/theme/unrar.png"),
	dup = kernel.loadimage("system/theme/dup.png"),
	myscreens = {}
}
 -- ## Sonidos ##
sound_scroll = kernel.loadsound("system/sounds/scroll.mp3")
sound_go= kernel.loadsound("system/sounds/go.mp3")
sound_ext = kernel.loadsound("system/sounds/ext.mp3")
sound_back = kernel.loadsound("system/sounds/back.mp3")

-- ## Configuraciones ##
if not files.exists("ms0:/oneinstaller/") then files.mkdir("ms0:/oneinstaller/")  end
if not files.exists("ms0:/oneinstaller/notices/") then files.mkdir("ms0:/oneinstaller/notices/") end
if not files.exists("ms0:/oneinstaller/tmp/") then files.mkdir("ms0:/oneinstaller/tmp/") end
if not files.exists("ms0:/oneinstaller/lang/") then files.mkdir("ms0:/oneinstaller/lang/"); files.copy("system/langs/spa.lua","ms0:/oneinstaller/lang/spa.lua"); files.copy("system/langs/eng.lua","ms0:/oneinstaller/lang/eng.lua"); files.copy("system/langs/fre.lua","ms0:/oneinstaller/lang/fre.lua"); end
pathini="ms0:/oneinstaller/config.ini" -- pendiente pues sera para dejarlo en una ruta absoluta
function write_table(pathini, tb)
    local file = io.open(pathini, "w+")
	file:write("config = {\n")
	for s,t in pairs(tb) do
		if type(t) == "string" then
		file:write(string.format('"%s",\n', tostring(t)))
		else
		file:write(string.format('%s,\n', tostring(t)))
		end
	end
	file:write("}")
	file:close()
end
-- 1: col bar, 2:  Root Wallpaper, pendiente: device work
config = {7,""}
if files.exists(pathini) then dofile(pathini)
else write_table(pathini, config) end
--background = kernel.loadimage(config[2]) -- Back Definido
if not background then
	background = kernel.loadimage("system/theme/default.jpg") -- el fondo
end
lastnowversion = 210
lastupdateversion = 210
-- ## Librerias ##
kernel.dofile("system/libs/utf8.lua")-- Manipulacion de Strings utf8
kernel.dofile("system/libs/lib_osc.lua")-- Funciones de osciladores
osc.init(1,255,4) -- creamos un oscilador, minimo, maximo, salto
kernel.dofile("system/libs/lib_grafics.lua") -- funciones patrones graficos
kernel.dofile("system/libs/lib_wave.lua")-- Funcion Grafica de Ola
WAVE.init("system/theme/wave.png")
kernel.dofile("system/libs/http.lua") -- Funciones de peticion http
box.init("system/theme/") -- inicia la libreria box mensajes! :D
-- ## Modulos ##
-- SE ESTA ELIMINANDO :D 
--[[
kernel.dofile("system/modules/comments.lua")
kernel.dofile("system/modules/manager_plugins.lua")]]

-- ## Colores Temas ##
MyBarColors={ -- Colores disponibles de barras
	color.new(0,0,0,55),		--1 BlackTrans
	color.new(139,0,0,135),		--2 RedTrans
	color.new(0,255,0,95),		--3 GreenTrnas
	color.new(255,255,0,95),	--4 YellowTrans
	color.new(64,224,208,135),	--5 TurquoiseTrans
	color.new(105,105,105,135),	--6 GrayTrans
	color.new(255,255,255,100),	--7 WhiteTrans
	color.new(55,72,251,105),	--8 BlueTrans
	color.new(255,130,0,100) --9 orangeTrans
}
MyTxtColors = color.white -- color de texto blanca default
MyTxtShadow = color.black -- sombra de texto negra "default"
MyScrColor = color.new(0,72,251) --Brillo de seleccion
MyLineColor = color.white

--[[
-- Pendiente pues a mi no me interesan los usuarios go xDDDDD
MyDevs = {"ms0:/","ef0:/"} -- Segun cual almacenamiento se trabaje
if files.exist(MyDevs[1]) and config[2] == 1 then 
	OverDev = MyDevs[1] 
else
	OverDev = MyDevs[2]
end]]

-- ## Algunas Funciones Graficas dedicadas a el ahorro de lineas ##
function draw_back(mode,trans)-- Dibuja el Fondo y efecto
	if trans == nil then trans = 255 end -- no se declara entonces 255 
	if background then	background:blit(0,0,trans)	end -- existe? entonces dibujamos el fondo
	if mode == nil then	WAVE.blit(2)	end -- no se declara entonces dibujamos la ola
end
__refreshMs = true -- constante encargada del reload de la ms
Batt = 0
function draw_topbar()
	draw.fillrect(5,5,470,20,barcolor)
	screen.print(10,8,lang.oi.." v2",0.7,MyTxtColors,MyTxtShadow)
	draw_batt(450,10)
	screen.print(400,10,Batt.."%",0.7,MyTxtColors,MyTxtShadow)
	draw.line(395,5,395,25,MyLineColor)
	local intensidad_wifi = wlan.strength()
	if wlan.isconnected() then
		if intensidad_wifi > 75 then
			frame = 3
		elseif intensidad_wifi > 50 then
			frame = 2
		elseif intensidad_wifi > 25 then
			frame = 1
		else
			frame = 0
		end
		icon.wifi:blitsprite(370,10,frame)
		screen.print(320,10,intensidad_wifi.."%",0.7,MyTxtColors,MyTxtShadow)
	else
		--icon.wifi[1]:blit(370,10)
		icon.wifi:blitsprite(370,10,0)
		screen.print(320,10,"0%",0.7,MyTxtColors,MyTxtShadow)
	end
	draw.line(318,5,318,25,MyLineColor)
	screen.print(243,8,os.getdate():sub(18),0.6,MyTxtColors,MyTxtShadow)
	draw.line(238,5,238,25,MyLineColor)
	icon.ms:blit(218,7)
	if __refreshMs then
		__refreshMs = false
		MS = os.infoms0()
		if MS.free then
			MS.txtfree = files.sizeformat(MS.free)
		end
	end
	screen.print(160,8,MS.txtfree,0.6,MyTxtColors,MyTxtShadow)
	draw.line(156,5,156,25,MyLineColor)
end
--Dibuja la bateria
__refreshBatt = 110 -- constante encargada del reload de la battery
function draw_batt(x,y)
	__refreshBatt = __refreshBatt + 1
	if __refreshBatt > 100 then
		__refreshBatt = 0
		if batt.exists () then
			Batt = batt.lifepercent()
			if Batt == "-" then
				draw.fillrect(x-3,y+2,3,5,color.new(255,255,255))
				draw.fillrect(x,y,20,10,color.new(255,255,255))		
				Batt = "0"
				return
			end
		else 
			draw.fillrect(x-3,y+2,3,5,color.white)
			draw.fillrect(x,y,20,10,color.white)
			return 
		end
	end
	if Batt > 75 then 
		thecolor = color.new(0,255,0)
	elseif Batt > 50 then
		thecolor = color.new(100,200,0)
	elseif Batt > 25 then
		thecolor = color.new(200,100,0)
	else
		thecolor = color.new(255,0,0)
	end
	draw.fillrect(x-3,y+2,3,5,color.white)
	draw.fillrect(x,y,20,10,color.white)
	draw.fillrect(x+1,y+1,18,8,thecolor)
end

-- ## Lenguajes ##
OverLang = os.language()
if OverLang == "ENGLISH" and files.exists("ms0:/oneinstaller/lang/eng.lua") then-- en
	kernel.dofile("ms0:/oneinstaller/lang/eng.lua")
elseif OverLang == "FRENCH" and files.exists("ms0:/oneinstaller/lang/fre.lua") then-- fr
	kernel.dofile("ms0:/oneinstaller/lang/fre.lua")
elseif OverLang == "SPANISH" and files.exists("ms0:/oneinstaller/lang/spa.lua") then-- esp
	kernel.dofile("ms0:/oneinstaller/lang/spa.lua")
else--eng
	kernel.dofile("system/langs/eng.lua")
end


-- ## Set Scroll Menu ##
scroll.set(1,lang.menu,4)

-- ## Menu Principal ##
-- ## Constantes:
OverTop = false -- estamos sobre el top o en las opciones?
PosTop = 0 -- numero de top donde estamos situados
OverVita = false -- estamos en algo que tenga que ver con vita?
OverCat = 1 -- Categoria sobre la que estamos
-- ## Rutas de los configuradores de plugs ##
plugs_path = {"ms0:/seplugins/vsh.txt","ms0:/seplugins/game.txt","ms0:/seplugins/pops.txt"}
if os.cfw() == "eCFW ARK" then
	local sra = files.listdirs("ms0:/psp/savedata/")
	if sra then
		local i = 1
		while i <= #sra do--for i=1, #sra do
			if files.exists(sra[i].path.."/FLASH0.ARK") then
				plugs_path[4] = sra[i].path.."/plugins.txt" -- ruta a el configurador de plug
				break
			end
			i = i + 1
		end
	end
end


function show_menu()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	icon.one:blit(15,25) -- el logo :P
	grafics.multi_rect(4,5,111,165,35,5,barcolor) --Patron 4 rect opciones
	
	-- ## Impresion de Opciones ##
	local y,numpos,i = 121,1,scroll[1].ini
	while i <= scroll[1].lim do--	for i=scroll[1].ini,scroll[1].lim do
		if i==scroll[1].sel and not OverTop then
			draw.fillrect(5,71+40*numpos,165,35,color.new(0,72,251,osc.get()))
		end 
		screen.print(87,y,lang.menu[i] or "",0.7,MyTxtColors,MyTxtShadow,512) -- centrado
		numpos,y,i = numpos + 1, y + 40,i+1
	end
	
	-- ## Impresion Barra Lateral ##
	if scroll[1].maxim> 4 then 
		local pos_height = math.max(155/scroll[1].maxim, 5)
		draw.fillrect(175, 111, 5, 155, barcolor)
		draw.fillrect(175, 111+((155-pos_height)/(scroll[1].maxim-1))*(scroll[1].sel-1), 5, pos_height, MyScrColor)
	end
	
	-- ## Mostramos Los Top Three ##
	trans = osc.get()
	if PosTop == 1 and Top_1 then --size(285,115)
		Top_1:blit(190,30,255)
		grafics.selectrect(190,30,285,115,color.new(0,72,251,trans))
	elseif Top_1 then
		Top_1:blit(190,30,100)
	end
	if PosTop == 2 and Top_2 then --size(140,115)
		Top_2:blit(335,152,255)
		grafics.selectrect(335,152,140,115,color.new(0,72,251,trans))
	elseif Top_2 then
		Top_2:blit(335,152,100)
	end
	if PosTop == 3 and Top_3 then	
		Top_3:blit(190,152,255)
		grafics.selectrect(190,152,140,115,color.new(0,72,251,trans))
	elseif Top_3 then
		Top_3:blit(190,152,100)
	end
end

function ctrls_menu()
	if OverTop then -- estamos sobre los top entonces nos dezplasamos sobre ellos 
		if buttons.up and (PosTop == 2 or PosTop == 3) then sound_scroll:play() PosTop = 1 end
		if buttons.down and PosTop == 1 then sound_scroll:play() PosTop = math.random(2,3) end
		if buttons.right and PosTop == 3 then sound_scroll:play() PosTop = 2 end
		if buttons.left and (PosTop == 3 or PosTop == 1) then sound_scroll:play() PosTop = 0 OverTop = false end
		if buttons.left and PosTop == 2 then sound_scroll:play() PosTop = 3 end
		if buttons.cross then
			sound_go:play()
			OverCat = 9 -- categoria de los top
			scroll.set(3,Lista[OverCat],4)
			scroll[3].sel = PosTop
			scroll.set(4,Lista[OverCat][scroll[3].sel].description,8)
			Seccion = 4
		end
	else -- estamos sobre las opciones 
		if buttons.down or buttons.held.r then osc.defmax() sound_scroll:play() scroll.down(1) end
		if buttons.up or buttons.held.l then osc.defmax() sound_scroll:play() scroll.up(1) end
		if buttons.right then sound_scroll:play() PosTop = 1 OverTop = true end		
		if buttons.cross then
			sound_go:play()
			if scroll[1].sel == 1 then -- PSP/VITA
				Seccion = 2
			elseif scroll[1].sel == 2 then -- Explorer Files
				explorer.main()
			elseif scroll[1].sel == 3 then -- Manager Of Plugins
				box.new("Not Available","In this version, this option was not added")
			elseif scroll[1].sel == 4 then -- Send/Read Comments
				box.new("Not Available","In this version, this option was not added")
				--[[
				local debugtab = ""
				for s,t in pairs(ContactList) do
					debugtab = debugtab.."key:"..s.." value:"..type(t).."{\n"
					for ys,xs in pairs(t) do
						debugtab = debugtab.."key:"..ys.." value:"..xs.."\n"
					end
					debugtab = debugtab.."}\n"
				end
				
				for s,t in pairs(ContactList[1] or {}) do
					debugtab = debugtab.."key:"..s.." value:"..t.."\n"
				end
				local y = 10 
				while true do
				buttons.read()
				if buttons.held.up then y = y + 4 
				elseif buttons.held.down then y = y - 4 
				end
				if buttons.start then break end
				screen.print(10,y,debugtab)
				screen.flip()
				end
				usb.mstick  (  ) 
				os.restart()]]
				--scroll.set("contact",ContactList,4)
				--ContactList[1].msg = wordwrap(ContactList[1].msg,214,0.7)
				--Seccion = 6
			elseif scroll[1].sel == 5 then -- Configs
				Seccion = 8
			elseif scroll[1].sel == 6 then -- History App
				local myscreenback = screen.buffertoimage()
				about({lang.aboutapp,lang.aboutteam,lang.aboutthks})
				myscreenback:blit(0,0)
			elseif scroll[1].sel == 7 then -- EXIT
				kernel.exit()
			end
		end
	end
end

-- ## Set Scroll Categories ##
scroll.set(2,lang.cats,4)

-- ## Lista de Categorias ##
function show_cats()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	icon.one:blit(15,25) -- el logo :P
	grafics.multi_rect(4,5,111,165,35,5,barcolor) --Patron 4 rect opciones
	-- ## Impresion De Categorias ##
	local y,numpos,i= 121,1,scroll[2].ini
	while i <= scroll[2].lim do--	for i=scroll[2].ini,scroll[2].lim do  -- mayor rendimiento
		if i==scroll[2].sel then draw.fillrect(5,71+40*numpos,165,35,color.new(0,72,251,osc.get())) end --Brillo
		screen.print(87,y,lang.cats[i] or "",0.7,MyTxtColors,MyTxtShadow,512)
		numpos,y,i = numpos + 1, y + 40,i+1
	end
	-- ## Impresion Barra Lateral ##
	if scroll[2].maxim> 4 then
		local pos_height = math.max(155/scroll[2].maxim, 5)
		draw.fillrect(175, 111, 5, 155, barcolor)
		draw.fillrect(175, 111+((155-pos_height)/(scroll[2].maxim-1))*(scroll[2].sel-1), 5, pos_height, MyScrColor)
	end
	-- ## Detalles Graficos ##
	draw.fillrect(190,30,285,235,barcolor)--Fondo de la barra lateral
	screen.print(337,55,"--"..lang.cats[scroll[2].sel].."--",0.7,MyTxtColors,MyTxtShadow,512) -- titulo de la categoria
	
	if scroll[2].sel < 8 then 
		screen.print(337,75,lang.cnts..#Lista[scroll[2].sel],0.7,MyTxtColors,MyTxtShadow,512)
	end --contenidos de este reposito --#Lista[scroll[2].sel+large]
	icon.cats[scroll[2].sel]:blit(190+98,30+74) -- img correspondiente a la categoria
	screen.print(337,232,lang.lupr,0.6,MyTxtColors,MyTxtShadow,512) -- ultima vez actualizado del reposito
	screen.print(337,247,(lastupdaterepo or "unk"),0.6,MyTxtColors,MyTxtShadow,512)
end

function ctrls_cats()
	if buttons.down or buttons.held.r then
		osc.defmax() sound_scroll:play() scroll.down(2)
	end
	if buttons.up or buttons.held.l then
		osc.defmax() sound_scroll:play() scroll.up(2)
	end
	if buttons.circle then-- retorna al menu
		sound_back:play() Seccion = 1
	end 
	if buttons.cross and scroll[2].sel==8 then
		sound_go:play() search() -- la busqueda de un contenido
	elseif buttons.cross then sound_go:play() 
		OverCat = scroll[2].sel
		scroll.set(3,Lista[OverCat],4) Seccion = 3 -- pasa a el recorredor de contenido
	end 
end

function search()
	Lista[8] = {} -- limpiamos busquedas
	txt_to_search = osk.init(lang.find, "")
	if txt_to_search then
		for u=1,7 do
			for t=1,#Lista[u] do
				w,x = string.find(Lista[u][t].title:lower(), txt_to_search,1,true)
				if w then --Llenamos la tabla si se encuentra alguna coincidencia
					Lista[8][#Lista[8]+1] = Lista[u][t]
				end
			end
		end
	--	end
		if #Lista[8] > 0 then scroll.set(3,Lista[8],4) Seccion = 3 end
	end
end

-- ## Lista Contenidos ##
--Pendiente en este beta no hay licencias XD
--for i=1,#lang.lic do -- ajustamos licencias a el espacio
	--lang.lic[i] = wordwrap(lang.lic[i],155,0.7)
--end
listscroll = {200,200}
function show_ltcnt()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	icon.one:blit(15,25) -- el logo :P
	grafics.multi_rect(4,190,30,280,55,5,barcolor) --Patron 4 rect opciones
	-- ## Impresion De Listado ##
	local y,numpos,i = 55,0,scroll[3].ini
	while i <= scroll[3].lim do --for i=scroll[3].ini,scroll[3].lim do  -- Aunmento en un 75% de rendimiento al ser while
		if i==scroll[3].sel then -- Brillo, y scrolls 
			draw.fillrect(190,30+60*numpos,280,55,color.new(0,72,251,osc.get()))
			listscroll[2] = screen.print(listscroll[2],y+5,(Lista[OverCat][i].description[1] or ""),0.7,MyTxtColors,MyTxtShadow,__SLEFT,260)
		else -- Normal
			screen.clip(200,y,260,25)
			screen.print(200,y+5,Lista[OverCat][i].description[1] or "",0.7,MyTxtColors,MyTxtShadow)
			screen.clip()
		end
		listscroll[1] = screen.print(listscroll[1],y-15,i..". "..Lista[OverCat][i].title or "",0.7,MyTxtColors,MyTxtShadow,__SLEFT,260)
		numpos,y, i = numpos + 1, y + 60, i+1
	end
	-- ## Impresion Barra Lateral ##
	if scroll[3].maxim> 4 then
		local pos_height = math.max(235/scroll[3].maxim, 5)
		draw.fillrect(475, 30, 5, 235, barcolor)
		draw.fillrect(475, 30+((235-pos_height)/(scroll[3].maxim-1))*(scroll[3].sel-1), 5, pos_height, MyScrColor)
	end
	draw.fillrect(5,111,165,156,barcolor)--Pendiente en este beta no hay licencias XD
	--screen.print(8,103,lang.lic[scroll[2].sel],0.7,MyTxtColors,MyTxtShadow) -- licencia de categoria
end

function ctrls_ltcnt()
	if buttons.held.r or buttons.down then scroll.down(3) end
	if buttons.released.r or buttons.down then sound_scroll:play() end
	if buttons.held.l or buttons.up then scroll.up(3) end
	if buttons.released.l or buttons.up then sound_scroll:play() end
	if buttons.circle then sound_back:play() Seccion = 2 end
	if buttons.cross then sound_go:play()
	scroll.set(4,Lista[OverCat][scroll[3].sel].description,8)
	Seccion = 4 end
end
function cleanicon0()
	Lista[OverCat][scroll[3].sel].ico = nil
	collectgarbage()
end
--## Visor Contenidos ##
function ctrls_vrcnt()
	if buttons.r then cleanicon0() scroll.down(3) scroll.set(4,Lista[OverCat][scroll[3].sel].description,8) sound_scroll:play() end
	if buttons.l then cleanicon0() scroll.up(3) scroll.set(4,Lista[OverCat][scroll[3].sel].description,8) sound_scroll:play() end
	if buttons.circle and OverCat == 9 then cleanicon0() sound_back:play() Seccion = 1 end--Entramos por una noticia de la pagina principal
	if buttons.circle and OverCat ~= 9 then cleanicon0() sound_back:play() Seccion = 3 end--Entramos por la lista de manera normal xD
	
	if buttons.cross then -- descargar
		sound_go:play()
		local state = false
		if Lista[OverCat][scroll[3].sel].outrep then
			--os.message(Lista[OverCat][scroll[3].sel].url)
			state = DownInstall(Lista[OverCat][scroll[3].sel].url,Lista[OverCat][scroll[3].sel].title)
		else
			--os.message(Servidor.."apps/"..Lista[OverCat][scroll[3].sel].id..".zip")
			state = DownInstall(Servidor.."apps/"..Lista[OverCat][scroll[3].sel].id..".zip",Lista[OverCat][scroll[3].sel].title)
		end
		if state then 
			__refreshMs = true
			box.api(send_vote) -- Los obligamos a votar ya que fue un error haber hecho su eleccion xD
		else 
			sound_back:play() 
		end--Rewrite_NewPlugs()--respaldar_Plugs()
	end
	--[[if buttons.select then
		box.api(send_vote)
	end]]
	if buttons.held.down then scroll.down(4)
	elseif buttons.held.up then scroll.up(4)
	end
	if buttons.square then
		if Lista[OverCat][scroll[3].sel].captures > 0 then -- hay capturas?
			if downss() then  -- pedimos si retorna true pues las obtuvimos y pasamos a mostrarlas
				scroll.set(5,icon.myscreens,3)
				Seccion = 5
			else -- ya valio no obtuvimos nada
				box.new(lang.errors.titlescreens,lang.errors.serverlost)
			end
		end
	end
end
-- Entramos en el dialogo de La noticia o app
myscroll = {title = 15,version = 15,author = 85}
function show_vrcnt()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	draw.fillrect(5,30,330,237,barcolor) -- contenedor de la descripcion eh icono eh flags
	-- ## Title & Version & Author ##
	screen.print(15,45,lang.title,0.7,MyTxtColors,MyTxtShadow)
	myscroll["title"] = screen.print(myscroll["title"],60,Lista[OverCat][scroll[3].sel].title,0.7,MyTxtColors,MyTxtShadow,__SLEFT,160)
	screen.print(15,80,lang.version,0.7,MyTxtColors,MyTxtShadow)
	myscroll["version"] = screen.print(myscroll["version"],95,Lista[OverCat][scroll[3].sel].version,0.7,MyTxtColors,MyTxtShadow,__SLEFT,60)
	screen.print(85,80,lang.author,0.7,MyTxtColors,MyTxtShadow)
	myscroll["author"] = screen.print(myscroll["author"],95,Lista[OverCat][scroll[3].sel].author,0.7,MyTxtColors,MyTxtShadow,__SLEFT,90)
	-- ## ICON ##
	if not Lista[OverCat][scroll[3].sel].ico then
		if files.exists("ms0:/oneinstaller/notices/"..Lista[OverCat][scroll[3].sel].id..".png") then
			Lista[OverCat][scroll[3].sel].ico = image.load("ms0:/oneinstaller/notices/"..Lista[OverCat][scroll[3].sel].id..".png")
		else
			if OverCat == 5 or OverCat == 14 then
				local alternative = math.random(1,4)
				Lista[OverCat][scroll[3].sel].ico = image.copy(icon.prx[alternative])
			elseif OverCat == 4 or OverCat == 13 then
				local alternative = math.random(1,3)
				Lista[OverCat][scroll[3].sel].ico = image.copy(icon.ud[alternative])
			else
				local alternative = math.random(1,4)
				Lista[OverCat][scroll[3].sel].ico = image.copy(icon.hb[alternative])
			end
		end
	end
	Lista[OverCat][scroll[3].sel].ico:blit(185,35)
	-- ## Flags ##
	if OverTop then
		icon.flags.cats:blitsprite(58,35,8) -- Categoria
	else
		icon.flags.cats:blitsprite(58,35,scroll[2].sel-1) -- Categoria
	end
	icon.flags.model:blitsprite(86,35,Lista[OverCat][scroll[3].sel].model) -- Modelo
	draw_lang_ico(icon.flags.lang,Lista[OverCat][scroll[3].sel].lang)
	-- ## Description ##
	screen.print(15,120,lang.descr,0.7,MyTxtColors,MyTxtShadow)
	local h,i = 135,scroll[4].ini
	while i <= scroll[4].lim do--	for i=scroll[4].ini,scroll[4].lim do
		screen.print(15,h,Lista[OverCat][scroll[3].sel].description[i] or "",0.7,MyTxtColors,MyTxtShadow)
		h,i = h + 15, i+1
	end
	-- ## Impresion Barra Lateral Scroll ##
	if scroll[4].maxim > 8 then
		local pos_height = math.max(120/scroll[4].maxim, 8)
		draw.fillrect(320, 130, 5, 120, barcolor)
		draw.fillrect(320, 130+((120-pos_height)/(scroll[4].maxim-1))*(scroll[4].sel-1), 5, pos_height, MyScrColor)
	end
	-- ## Ranking Stars ##
	draw.fillrect(340,30,135,70,barcolor)
	screen.print(350,35,lang.rank,0.6,MyTxtColors,MyTxtShadow)
	if RankList[Lista[OverCat][scroll[3].sel].id] and RankList[Lista[OverCat][scroll[3].sel].id].votos > 0 then -- existe algo de ello?
		--RankList[Lista[OverCat][scroll[3].sel].id].media = math.floor(tonumber(RankList[Lista[OverCat][scroll[3].sel].id].puntos) / tonumber(RankList[Lista[OverCat][scroll[3].sel].id].votos))
		icon.stars:blitsprite(350,50,RankList[Lista[OverCat][scroll[3].sel].id].media)
		screen.print(407,70,RankList[Lista[OverCat][scroll[3].sel].id].media.." - 5",0.6,MyTxtColors,MyTxtShadow,512)
		screen.print(407,85,lang.lrank[RankList[Lista[OverCat][scroll[3].sel].id].media+1],0.6,MyTxtColors,MyTxtShadow,512)
	else -- nada entonces 0 stars XD
		icon.stars:blitsprite(350,50,0)
		screen.print(407,70,lang.norank,0.6,MyTxtColors,MyTxtShadow,512)	
	end
	-- # Downloads, Size & Rank #
	draw.fillrect(340,105,135,40,barcolor)
	icon.wn:blit(445,110)
	screen.print(345,110,lang.dls,0.6,MyTxtColors,MyTxtShadow)
	screen.print(345,125,Lista[OverCat][scroll[3].sel].fsize,0.7,MyTxtColors,MyTxtShadow)
	
	draw.fillrect(340,150,135,40,barcolor)--draw.fillrect(340,150,135,82,barcolor)
	icon.dl:blit(440,150)
	screen.print(345,155,lang.ins,0.6,MyTxtColors,MyTxtShadow)
	if RankList[Lista[OverCat][scroll[3].sel].id] then -- existe algo de ello?
		screen.print(390,170,RankList[Lista[OverCat][scroll[3].sel].id].down,0.7,MyTxtColors,MyTxtShadow,512)
	else
		screen.print(390,170,"0",0.7,MyTxtColors,MyTxtShadow)
	end
	-- ## ScreenShots ##
	draw.fillrect(340,195,135,40,barcolor)
	icon.ss:blit(430,195)
	screen.print(345,200,lang.ss,0.6,MyTxtColors,MyTxtShadow)
	screen.print(360,215,Lista[OverCat][scroll[3].sel].captures,0.7,MyTxtColors,MyTxtShadow)
	-- ## Download Button ##
	draw.fillrect(340,237,135,30,barcolor)
	draw.fillrect(340,237,135,30,color.new(0,72,255,osc.get()))
	screen.print(360,245,"X: "..lang.dl,0.6,MyTxtColors,MyTxtShadow)

end
function draw_lang_ico(img,index) 
    if index < 1 then return end
	local frame1,frame2,frame3,num = index - 1,0,0,1
    if index == 4 then	frame1,frame2,num = 0,1,2
	elseif index == 5 then	frame1,frame2,num = 0,2,2
	elseif index == 6 then	frame1,frame2,num = 1,2,2
	elseif index == 7 then	frame1,frame2,frame3,num = 0,1,2,3	end
	if num > 0 then	img:blitsprite(114,35,frame1) end
	if num > 1 then img:blitsprite(136,35,frame2) end
	if num > 2 then img:blitsprite(158,35,frame3) end
end
--## Visor ScreenShots ##
function ctrls_shots()
if buttons.down then scroll.down(5)
	elseif buttons.up then scroll.up(5)
	end
	if buttons.circle then
		Seccion = 4
	end
	if buttons.cross then
		icon.myscreens[scroll[5].sel]:resize(480,272)
		visorimg(icon.myscreens[scroll[5].sel],Lista[OverCat][scroll[3].sel].title)
		icon.myscreens[scroll[5].sel]:center(0,0)
	end
end
function show_shots()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	draw.fillrect(336,26,144,246,barcolor)
	screen.print(168,35,Lista[OverCat][scroll[3].sel].title,0.7,MyTxtColors,MyTxtShadow,__ACENTER)
	local pos = 0
	for i=1,scroll[5].maxim do
		icon.myscreens[i]:resize(144,82)
		icon.myscreens[i]:blit(336,(pos*82)+26)
		if i == scroll[5].sel then 
			grafics.selectrect(336,(pos*82)+26,144,82,color.new(0,72,255,osc.get()))
		end
		icon.myscreens[scroll[5].sel]:resize(336,190)
		icon.myscreens[scroll[5].sel]:blit(0,56)
		pos = pos + 1
	end
end
-- ## View Comments ##
function show_viewcomments()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	draw.fillrect(5,30,230,232,barcolor)--Fondo de la barra lateral
	screen.print(13,45,ContactList[scroll["contact"].sel].name,0.6,MyTxtColors,MyTxtShadow)
	screen.print(237,35,ContactList[scroll["contact"].sel].date,0.6,MyTxtColors,MyTxtShadow,__ARIGHT)
	screen.print(13,55,ContactList[scroll["contact"].sel].msg,0.7,MyTxtColors,MyTxtShadow)
	--icon.one:blit(15,25) -- el logo :P
	grafics.multi_rect(4,240,30,230,55,5,barcolor) --Patron 4 rect opciones
	-- ## Impresion De Listado ##
	local y,numpos,i = 55,0,scroll["contact"].ini
	while i <= scroll["contact"].lim do --for i=scroll[3].ini,scroll[3].lim do  -- Aunmento en un 75% de rendimiento al ser while
		if i==scroll["contact"].sel then -- Brillo, y scrolls 
			draw.fillrect(240,30+60*numpos,230,55,color.new(0,72,251,osc.get()))
		end
		screen.clip(235,y-20,230,y+7)
		screen.print(243,y+5,ContactList[i].msg or "",0.7,MyTxtColors,MyTxtShadow)
		screen.print(243,y-15,i..". "..ContactList[i].name or "",0.7,MyTxtColors,MyTxtShadow,__SLEFT,260)
		screen.clip()
		numpos,y, i = numpos + 1, y + 60, i+1
	end
	
	-- ## Impresion Barra Lateral ##
	if scroll["contact"].maxim> 4 then
		local pos_height = math.max(235/scroll["contact"].maxim, 5)
		draw.fillrect(475, 30, 5, 235, barcolor)
		draw.fillrect(475, 30+((235-pos_height)/(scroll["contact"].maxim-1))*(scroll["contact"].sel-1), 5, pos_height, MyScrColor)
	end
	
	
end
txt_reporter = "" -- texto del formulario
function ctrls_viewcomments()
	if buttons.up then scroll.up("contact")
	ContactList[scroll["contact"].sel].msg = wordwrap(ContactList[scroll["contact"].sel].msg,214,0.7)
	elseif buttons.down then scroll.down("contact")
	ContactList[scroll["contact"].sel].msg = wordwrap(ContactList[scroll["contact"].sel].msg,214,0.7)
	end
	if buttons.circle then Seccion = 1 end -- retornamos al menu
	if buttons.cross then Seccion = 7 end -- nos pasamos al postform o enviador
end
-- ## Send Comments ##
function ctrls_formcomments()
	if buttons.circle then Seccion = 6 end -- retornamos al visor comentarios
	if buttons.cross then -- enviamos
		if send_reporter(txt_reporter) == true then
			ContactList[#ContactList+1] = {name = os.nick(),date = os.getdate(),msg = txt_reporter}
			scroll.max("contact",ContactList)
			Seccion = 6
			txt_reporter = "" 
		else
			box.new("Error No send","Comentario o mensaje no enviado")
			Seccion = 6
			txt_reporter = "" 
		end
	end 
	if buttons.square then --editamos txt
		local out_txt = osk.init("txt",txt_reporter)
		if out_txt then
			txt_reporter = wordwrap(out_txt,214,0.7)--quite el explode,"\n")
		end
	end 
end
function show_formcomments()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	draw.fillrect(5,30,230,235,barcolor)--Fondo de la barra lateral
	screen.print(8,45,os.nick(),0.6,MyTxtColors,MyTxtShadow)
	screen.print(234,35,os.getdate(),0.6,MyTxtColors,MyTxtShadow,__ARIGHT)
	screen.print(8,55,txt_reporter,0.6,MyTxtColors,MyTxtShadow)
	draw.fillrect(240,30,235,235,barcolor)--Fondo de la barra lateral
	screen.print(243,45,ContactList[scroll["contact"].sel].name,0.7,MyTxtColors,MyTxtShadow)
	screen.print(271,35,ContactList[scroll["contact"].sel].date,0.6,MyTxtColors,MyTxtShadow,__ARIGHT)
	screen.print(243,55,ContactList[scroll["contact"].sel].msg,0.7,MyTxtColors,MyTxtShadow)
	
end
function send_reporter(tab)
	tab = string.explode(tab,"\n")
	local new_line = string.char(92,110)
	local form_send = table.concat(tab, new_line)	
	local comilles = string.char(34)
	if string.len(form_send) > 0 then
		os.message(form_send)
		local result = http.post(Servidor.."contact.php?action=add","name="..os.nick().."&".."lang="..os.language().."&".."msg="..form_send)
		if result then
			return true
		end
	end
	return false
end
-- ## Configurador ##
function show_configs()
	draw_back() -- Dibuja el fondo
	draw_topbar() -- dibuja la barra superior
	icon.one:blit(15,25) -- el logo :P
	draw.fillrect(5,100,150,167,barcolor)
	screen.print(20,110,lang.info.title,0.6,MyTxtColors,MyTxtShadow)
	screen.print(20,125,lang.info.firm..(os.cfw() or "Unk"),0.6,MyTxtColors,MyTxtShadow)
	screen.print(20,140,lang.info.model..(hw.getmodel() or "Unk"),0.6,MyTxtColors,MyTxtShadow)
	screen.print(20,155,lang.info.gen..hw.gen() or "",0.6,MyTxtColors,MyTxtShadow)
	screen.print(20,170,lang.info.region..hw.region() or "",0.6,MyTxtColors,MyTxtShadow)
	draw.fillrect(160,30,315,237,barcolor)
	screen.print(170,40,"Press R to change temp color theme",0.6,MyTxtColors,MyTxtShadow)
	--\nPress Select: Active TV\nPress Start Disable TV",0.6,MyTxtColors,MyTxtShadow)
end
function ctrls_configs()
	if buttons.r then config[1] = config[1] + 1 if config[1] > 9 then config[1] = 1 end end
	--if buttons.select then os.modetv(__8888) end
	--if buttons.start then os.modetv() end
	--if buttons.l then config[2] = config[2] + 1 if config[2] > 9 then config[2] = 1 end end
	if buttons.circle then -- salimos del configurador
		sound_scroll:play()
		Seccion = 1
	end
end
-- ## Home Menu ##
home_pos = 0
function api_homemenu(x1,y1,x2,y2)
	screen.print(x1,y1,"OneInstaller Menu",0.6,color.white,color.black,512) -- titulo
	draw.fillrect(x2,(home_pos*15)+y2,310,15,barcolor)
	if wlan.isconnected() then
	screen.print(x1,y2,lang.home.disconect,0.6,color.white,color.black,512)
	else
	screen.print(x1,y2,lang.home.conect,0.6,color.white,color.black,512)
	end
	y2 = y2 + 15
	if usb.isactive() then
	screen.print(x1,y2,lang.home.disableusb,0.6,color.white,color.black,512)
	else
	screen.print(x1,y2,lang.home.enableusb,0.6,color.white,color.black,512)
	end
	y2 = y2 + 15
	screen.print(x1,y2,lang.home.suspend,0.6,color.white,color.black,512)
	y2 = y2 + 15
	screen.print(x1,y2,lang.home.off,0.6,color.white,color.black,512)
	y2 = y2 + 15
	screen.print(x1,y2,lang.home.exit,0.6,color.white,color.black,512)
	y2 = y2 + 15
	screen.print(x1,y2,lang.home.cancel,0.6,color.white,color.black,512)
	if buttons.up and home_pos > 0 then
	home_pos = home_pos - 1
	elseif buttons.down and home_pos < 5  then
	home_pos = home_pos + 1
	end
	if buttons.circle then
		box.close()
		home_pos = 0
	end
	if buttons.cross then
		if home_pos == 0 then
			if wlan.isconnected() then
				wlan.disconnect  (  ) 
			else
				wlan.connect  (  ) 
			end
		elseif home_pos == 1 then
			if usb.isactive() then
				usb.stop  (  ) 
			else
				usb.mstick  (  ) 
			end
		elseif home_pos == 2 then
			kernel.fadeout()
			power.suspend()
		elseif home_pos == 3 then
			kernel.fadeout()
			power.off  (  ) 
		elseif home_pos == 4 then
			kernel.exit()
		end
		--game.add("eboot.pbp","ICON0.PNG",__ICON0)
		--game.add("eboot.pbp","SND0.AT3",__AT3)
		box.close()
		home_pos = 0
	end
end
-- ## Funciones Net Oneinstaller ##
-- ## Actualiza el System ## (todo)
function Update_Sys()
	myback = screen.buffertoimage()
	box.ine(myback)
	tiempo:reset()
	tiempo:start()
	http.savefile(Servidor.."oneinstaller.rar","ms0:/oneinstaller/tmp/update.rar")
	tiempo:reset()
	tiempo:start()
	files.extract_w_bar("ms0:/oneinstaller/tmp/update.rar","ms0:/",CB_Up_Sys)--extrae con barra de accion completa
	files.delete("ms0:/oneinstaller/tmp/update.rar")
	myback:blit(0,0)
	box.back:blit(240,136)
	screen.print(240,84,lang.cupds,0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,100,lang.oi.. " " ..lang.rupds,0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,175,lang.ok,0.6,MyTxtColors,MyTxtShadow,512)
	screen.flip()
	buttons.waitforkey()
	box.out(myback)
	myback:blit(0,0)
end	
-- ## Actualiza el Core (Files News) ##
function Update_Core()
	onNetGetFile = CB_Dl_Core -- cambiamos el callback a el de install core
	progressupdate = 0
	-- ## Reposito ##
	fileupdated = "Repository"
	http.savefile(Servidor.."repo.php?action=get&lang="..os.language(),"ms0:/oneinstaller/tmp/repository.lua")
	if files.exists("ms0:/oneinstaller/tmp/repository.lua") then
		--dofile("ms0:/oneinstaller/tmp/repository.lua")	
		runok, str = pcall(dofile, "ms0:/oneinstaller/tmp/repository.lua")--Cargamos el script a prueba de errores
		-- Obtengo los distintos resultados de error
		if not runok then -- un error reintentaremos
			box.new(lang.errors.titlerepo,lang.errors.againrepo)
			http.savefile(Servidor.."repo.php?action=get&lang="..os.language(),"ms0:/oneinstaller/tmp/repository.lua")
		end
	else
		box.new(lang.errors.titlerepo,lang.errors.againrepo)
		if http.savefile(Servidor.."repo.php?action=get&lang="..os.language(),"ms0:/oneinstaller/tmp/repository.lua") then
			kernel.dofile("ms0:/oneinstaller/tmp/repository.lua")
		else
			os.exit()
		end
	end
	if lastupdateversion > lastnowversion then
		draw_back(true)
		local response = box.new(lang.tupds, {lang.mupds,lang.vaupds..lastnowversion,lang.vdupds..lastupdateversion},true)
		if response then 
			Update_Sys()
			--en iso no puede reiniciar y de momentos pues asi dare el released
			os.exit()--os.restart()
		else
			os.exit()
		end
	end
	progressupdate = 20
	-- ## Valoraciones y Descargas ##
	fileupdated = "Rankings"
	http.savefile(Servidor.."ranking.php?dl=1","ms0:/oneinstaller/tmp/ranking.lua")
	if files.exists("ms0:/oneinstaller/tmp/ranking.lua") then
		RankList = ini.load("ms0:/oneinstaller/tmp/ranking.lua") -- cargamos la tabla :D
	end
	progressupdate = 50
	-- ## Comentarios ##
	--[[fileupdated = "Contacts"
	http.savefile(Servidor.."contact.php?action=get","ms0:/oneinstaller/tmp/contact.lua")
	if files.exists("ms0:/oneinstaller/tmp/contact.lua") then
		ContactList = ini.load("ms0:/oneinstaller/tmp/contact.lua") -- cargamos la tabla :D
	end
	progressupdate = 40]]
	-- ## Portadas ##
	fileupdated = "TOP 1"
	Top_1 = http.image(Servidor.."portada_1.jpg",1)
	progressupdate = 60
	fileupdated = "TOP 2"
	Top_2 = http.image(Servidor.."portada_2.jpg",1)
	progressupdate = 70
	fileupdated = "TOP 3"
	Top_3 = http.image(Servidor.."portada_3.jpg",1)
	progressupdate = 90
	if not Top_1 then
		Top_1 = image.load("system/theme/top_1.png")
	end
	if not Top_2 then
		Top_2 = image.load("system/theme/top_2.png")
	end
	if not Top_3 then
		Top_3 = image.load("system/theme/top_2.png")
	end
	-- ## Login ##
	fileupdated = "Login"
	http.post(Servidor.."login.php","username="..os.nick().."&".."lang="..os.language().."&".."model="..hw.getmodel().."&".."gen="..hw.gen().."&".."reg="..hw.region().."&".."fw="..os.cfw())
	progressupdate = 100
	local myscreenback = screen.buffertoimage()
	box.ine(myscreenback)
	getmyicons = {}
	for __category=1 ,7 do -- Translate all repo to table & check icons or postsave zip & extract
		for __idxc=1,#Lista[__category] do
			if not files.exists("ms0:/oneinstaller/notices/"..Lista[__category][__idxc].id..".png") and Lista[__category][__idxc].defico == false then 
				getmyicons[#getmyicons+1] = Lista[__category][__idxc].id
			end
			myscreenback:blit(0,0)
			box.back:blit(240,136)
			screen.print(240,84,"Check Repo",0.6,MyTxtColors,MyTxtShadow,512)
			screen.print(240,100,"ID: "..Lista[__category][__idxc].id,0.6,MyTxtColors,MyTxtShadow,512)
			screen.flip()
			Lista[__category][__idxc].description = string.explode(wordwrap(Lista[__category][__idxc].description or "",300,0.7) or "", "\n") or {""}
			end
	end
	for i=1,#Lista[9] do -- tops
		myscreenback:blit(0,0)
		box.back:blit(240,136)
		screen.print(240,84,"Check Repo",0.6,MyTxtColors,MyTxtShadow,512)
		screen.print(240,100,"ID: "..Lista[9][i].id,0.6,MyTxtColors,MyTxtShadow,512)
		screen.flip()
		Lista[9][i].description = string.explode(wordwrap(Lista[9][i].description or "",300,0.7) or "", "\n") or {""}
	end
	box.out(myscreenback)
	myscreenback:blit(0,0)
	--os.message(#getmyicons)
	if #getmyicons > 0 then
		getmyicons = string.implode(getmyicons,"#")
		draw_back(true)
		myback = screen.buffertoimage()
		box.ine(myback)
		tiempo:reset()	tiempo:start()
		onNetGetFile = CB_Dl_Ico -- cambiamos el callback a el de install icons
		http.postsave(Servidor.."repo.php?action=icons","rest="..getmyicons,"ms0:/oneinstaller/tmp/mynewicons.zip")
		tiempo:reset()	tiempo:start()
		files.extract_w_bar("ms0:/oneinstaller/tmp/mynewicons.zip","ms0:/oneinstaller/notices/",CB_Up_Ico)--extrae con barra de accion completa
		files.delete("ms0:/oneinstaller/tmp/mynewicons.zip")
		box.out(myback)
		myback:blit(0,0)
	end
end
-- Descarga las capturas
function downss()
	onNetGetFile = CB_Dl_Screens
	__numdlscrsho = 1
	local _id = Lista[OverCat][scroll[3].sel].id
	local _nss = Lista[OverCat][scroll[3].sel].captures
	myback = screen.buffertoimage()
	box.ine(myback)
	local tmpcaps = {}
	for i=1,_nss do
		tmpcaps[#tmpcaps+1] =  http.image(Servidor.."apps/".._id.."_"..i..".jpg",1)
		__numdlscrsho = __numdlscrsho + 1
	end
	if #tmpcaps > 0 then
		icon.myscreens = tmpcaps
		tmpcaps = nil
		collectgarbage("collect")
		box.out(myback)
		myback:blit(0,0)
		return true
	elseif #icon.myscreens > 0 then -- permite la entrada offline si habia caches
		tmpcaps = nil
		collectgarbage("collect")
		box.out(myback)
		myback:blit(0,0)
		return true
	end
	box.out(myback)
	myback:blit(0,0)
	return false
end
-- ## Descarga & Instala ##
if not tiempo then tiempo = timer.new() end -- creamos un timer
function DownInstall(url,title,preser)
	os.cpu(333) -- Temporalmente Forza Maxima CPU
	local capt = screen.buffertoimage()
	if wlan.isconnected() == false then wlan.connect() end -- No estamos Conectados? se conecta
	if wlan.isconnected() == false then box.new(lang.nowif, lang.dlab,true) return end
	if Lista[OverCat][scroll[3].sel].size > MS.free then box.new(lang.nospc,lang.dlab,true) return end
	file_installed = title or ""
	onNetGetFile = CB_Dl_Cont -- cambiamos el callback a el de install content
	tiempo:reset()
	tiempo:start()
	state = http.savefile(url,"ms0:/oneinstaller/tmp/install.zip")--wlan.getfile(url,"install.zip")
	if state then
		http.post(Servidor.."ranking.php","id="..Lista[OverCat][scroll[3].sel].id.."&".."down=1")
		if not RankList[Lista[OverCat][scroll[3].sel].id] then RankList[Lista[OverCat][scroll[3].sel].id] = {media = 0, puntos = 0, votos = 0,down = 0} end
		RankList[Lista[OverCat][scroll[3].sel].id].down = RankList[Lista[OverCat][scroll[3].sel].id].down + 1
		ini.save("ms0:/oneinstaller/tmp/ranking.lua", RankList)
	end
	tiempo:stop()
	if state then
		local _rs = files.compress_size("ms0:/oneinstaller/tmp/install.zip")
		if _rs and _rs > MS.free then box.new(lang.nospc,lang.insab,true) return end
		local plugs = {}
		
		if OverCat == 5 then -- respalda plugs
			plugs.data = {}
			for i=1,#plugs_path do
				plugs.data[i] = files.read(plugs_path[i]) -- quitar el . al plugs.path
			end
		end
		files.extract_w_bar("ms0:/oneinstaller/tmp/install.zip","ms0:/",CB_Up_Cont)--extrae con barra de accion completa
		if OverCat == 5 then -- restaura plugs
			if #plugs.data > 0 then
				for i=1,#plugs_path do
					if plugs.data[i] then
						files.write(plugs_path[i],"\n"..plugs.data[i],"a+")
					end
				end
			end
		end
		if not preser then files.delete("ms0:/oneinstaller/tmp/install.zip") end -- pienso algunos querran guardar contenidos
	end
	os.cpu(222) -- volvemos a bajar la velocidad CPU
	capt:blit(0,0)
	return state
end
-- Callback Install & Download Content ##
function CB_Dl_Cont(size,bytes)
	draw_back(true) -- Dibuja fondo sin Animacion.
	draw.fillrect(5,5,470,20,barcolor)
	screen.print(240,8,lang.oi,0.7,MyTxtColors,MyTxtShadow,512)
	-- ## Download ##
	draw.fillrect(5,30,470,115,barcolor)
	icon.fb:blit(10,35)
	screen.print(63,50,file_installed,0.7,MyTxtColors,MyTxtShadow)
	screen.print(63,70,files.sizeformat(size),0.7,MyTxtColors,MyTxtShadow)
	
	grafics.loadbar(10,100,460,21,math.floor(bytes*(456)/size),color.white,color.green)
	screen.print(240,105,files.sizeformat(bytes),0.7,MyTxtColors,MyTxtShadow,__ACENTER)
	screen.print(420,35,math.floor(bytes*(100)/size).." % ",0.7,MyTxtColors,MyTxtShadow)
	TiempoDescarga = (tiempo:time()/1000)
	VelocidadDescarga = (bytes/1024)/TiempoDescarga
	Tamano= size/1024
	--icono.down:blit(30,123)
	screen.print(52,128,string.format("%.2f",VelocidadDescarga).."KB/s",0.7,MyTxtColors,MyTxtShadow)
	--icono.timer:blit(200,123)
	screen.print(360,128,string.format("%.2f",(Tamano/VelocidadDescarga)-TiempoDescarga).."s",0.7,MyTxtColors,MyTxtShadow)
	-- ## Un pack ##
	draw.fillrect(5,150,470,115,barcolor)
	icon.ur:blit(10,155)
	--draw.fillrect(340,30,135,235,barcolor)
	screen.flip()
end

function CB_Up_Cont(size,bytes,file)
	draw_back(true) -- Dibuja fondo sin Animacion.
	draw.fillrect(5,5,470,20,barcolor)
	screen.print(240,8,lang.oi,0.7,MyTxtColors,MyTxtShadow,512)
	draw.fillrect(5,30,470,115,barcolor)
	icon.fb:blit(10,35)
	screen.print(240,105,lang.complete,0.7,MyTxtColors,MyTxtShadow,__ACENTER)
	draw.fillrect(5,150,470,115,barcolor)
	icon.ur:blit(10,155)
	--Instalador real xD
	screen.print(63,160,file_installed,0.7,MyTxtColors,MyTxtShadow)
	screen.print(63,185,files.nopath(file),0.7,MyTxtColors,MyTxtShadow)
	TiempoExtract = tiempo:time()/1000
	VelocidadExtract = (extract_total_write/1024)/TiempoExtract
	Tamano = extract_total_size/1024
	--icono.down:blit(30,245)
	screen.print(52,248,string.format("%.2f",VelocidadExtract).."KB/s",0.7,MyTxtColors,MyTxtShadow)
	--icono.timer:blit(200,245)
	screen.print(360,248,string.format("%.2f",(Tamano/VelocidadExtract)-TiempoExtract).."s",0.7,MyTxtColors,MyTxtShadow)
	if file == fileant then
		extract_total_write = extract_total_write + bytes - antbytes
	else
		extract_total_write = extract_total_write + bytes
	end
	screen.print(420,155,math.floor(bytes*(100)/size).." % ",0.7,MyTxtColors,MyTxtShadow)
	grafics.loadbar(10,220,460,21,math.floor(extract_total_write*(456)/extract_total_size),color.white,color.green)
	--screen.print(285,235,extract_total_size,0.7,MyTxtColors,MyTxtShadow)
	screen.flip()
	
	antbytes = bytes
	fileant = file
end
 -- ## Callback Down Updates ##
function CB_Dl_Core(size,bytes)
	draw_back(true) -- Dibuja fondo sin Animacion.
	draw.fillrect(5,5,470,20,barcolor)
	screen.print(240,8,lang.oi,0.7,MyTxtColors,MyTxtShadow,512)
	
	draw.fillrect(5,30,470,237,barcolor)
	screen.print(35,40,lang.tupcore,0.8,MyTxtColors,MyTxtShadow)
	icon.dup:blit(271,9)
	icon.fb:blit(25,85)
	screen.print(80,105,fileupdated,0.8,MyTxtColors,MyTxtShadow)
	screen.print(80,125,files.sizeformat(size),0.8,MyTxtColors,MyTxtShadow)
	grafics.loadbar(25,170,264,21,math.floor(bytes*(260)/size),color.white,color.green)
	screen.print(157,175,files.sizeformat(bytes),0.7,MyTxtColors,MyTxtShadow,__ACENTER)
	screen.print(260,150,math.floor(bytes*(100)/size).." % ",0.7,MyTxtColors,MyTxtShadow)
	grafics.loadbar(25,228,430,21,math.floor(progressupdate*(4.30)),color.white,color.green)
	screen.print(240,208,progressupdate.." % ",0.7,MyTxtColors,MyTxtShadow)
	screen.flip()
end
 -- ## Callback Down ScreenShots ##
function CB_Dl_Screens(size,bytes)
	if myback then
		myback:blit(0,0) -- Dibuja fondo sin Animacion.
	end
	box.back:blit(240,136)
	screen.print(240,84,lang.dupds,0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,100,"Screen Shots",0.6,MyTxtColors,MyTxtShadow,512)
	icon.fi:blit(90,98)
	screen.print(145,115,__numdlscrsho.."/"..Lista[OverCat][scroll[3].sel].captures,0.6,MyTxtColors,MyTxtShadow)
	grafics.loadbar(89,164,303,21,math.floor(bytes*(300)/size),color.gray,color.green)
	screen.print(240,144,math.floor(bytes*(100)/size).." % ",0.7,MyTxtColors,MyTxtShadow,512)
	screen.flip()
end

-- ## Callback Install & Download System ##
function CB_Dl_Sys(size,bytes)
	if myback then
		myback:blit(0,0) -- Dibuja fondo sin Animacion.
	end
	box.back:blit(240,136)
	screen.print(240,84,lang.hupds,0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,100,lang.dupds,0.6,MyTxtColors,MyTxtShadow,512)
	--screen.print(80,125,files.sizeformat(size),0.8,MyTxtColors,MyTxtShadow)
	grafics.loadbar(89,140,303,21,math.floor(bytes*(300)/size),color.gray,color.green)
	screen.print(240,144,math.floor(bytes*(100)/size).." % ",0.7,MyTxtColors,MyTxtShadow,512)
	screen.print(240,165,files.sizeformat(bytes).."/"..files.sizeformat(size),0.7,MyTxtColors,MyTxtShadow,__ACENTER)
	TiempoDescarga = (tiempo:time()/1000)
	VelocidadDescarga = (bytes/1024)/TiempoDescarga
	Tamano= size/1024
	screen.print(151,175,string.format("%.2f",VelocidadDescarga).."KB/s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.print(327,175,string.format("%.2f",(Tamano/VelocidadDescarga)-TiempoDescarga).."s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.flip()
end
function CB_Up_Sys(size,bytes,file)
	if myback then
		myback:blit(0,0) -- Dibuja fondo sin Animacion.
	end
	box.back:blit(240,136)
	screen.print(240,84,lang.hupds,0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,100,lang.iupds,0.6,MyTxtColors,MyTxtShadow,512)
	--screen.print(80,125,files.sizeformat(size),0.8,MyTxtColors,MyTxtShadow)
	grafics.loadbar(89,140,303,21,math.floor(extract_total_write*(300)/extract_total_size),color.gray,color.green)
	screen.print(240,144,math.floor(extract_total_write*(100)/extract_total_size).." % ",0.7,MyTxtColors,MyTxtShadow,512)
	screen.print(240,165,files.sizeformat(extract_total_write).."/"..files.sizeformat(extract_total_size),0.7,MyTxtColors,MyTxtShadow,__ACENTER)

	TiempoExtract = tiempo:time()/1000
	VelocidadExtract = (extract_total_write/1024)/TiempoExtract
	Tamano = extract_total_size/1024

	screen.print(151,175,string.format("%.2f",VelocidadExtract).."KB/s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.print(327,175,string.format("%.2f",(Tamano/VelocidadExtract)-TiempoExtract).."s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.flip()
	if file == fileant then
		extract_total_write = extract_total_write + bytes - antbytes
	else
		extract_total_write = extract_total_write + bytes
	end
	antbytes = bytes
	fileant = file
end

-- ## Callback Install icons ##
function CB_Dl_Ico(size,bytes)
	if myback then
		myback:blit(0,0) -- Dibuja fondo sin Animacion.
	end
	box.back:blit(240,136)
	screen.print(240,84,lang.hupds.." Icons",0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,100,lang.dupds,0.6,MyTxtColors,MyTxtShadow,512)
	--screen.print(80,125,files.sizeformat(size),0.8,MyTxtColors,MyTxtShadow)
	grafics.loadbar(89,140,303,21,math.floor(bytes*(300)/size),color.gray,color.green)
	screen.print(240,144,math.floor(bytes*(100)/size).." % ",0.7,MyTxtColors,MyTxtShadow,512)
	screen.print(240,165,files.sizeformat(bytes).."/"..files.sizeformat(size),0.7,MyTxtColors,MyTxtShadow,__ACENTER)
	TiempoDescarga = (tiempo:time()/1000)
	VelocidadDescarga = (bytes/1024)/TiempoDescarga
	Tamano= size/1024
	screen.print(151,175,string.format("%.2f",VelocidadDescarga).."KB/s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.print(327,175,string.format("%.2f",(Tamano/VelocidadDescarga)-TiempoDescarga).."s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.flip()
end
function CB_Up_Ico(size,bytes,file)
	if myback then
		myback:blit(0,0) -- Dibuja fondo sin Animacion.
	end
	box.back:blit(240,136)
	screen.print(240,84,lang.hupds.." Icons",0.6,MyTxtColors,MyTxtShadow,512)
	screen.print(240,100,lang.iupds,0.6,MyTxtColors,MyTxtShadow,512)
	--screen.print(80,125,files.sizeformat(size),0.8,MyTxtColors,MyTxtShadow)
	grafics.loadbar(89,140,303,21,math.floor(extract_total_write*(300)/extract_total_size),color.gray,color.green)
	screen.print(240,144,math.floor(extract_total_write*(100)/extract_total_size).." % ",0.7,MyTxtColors,MyTxtShadow,512)
	screen.print(240,165,files.sizeformat(extract_total_write).."/"..files.sizeformat(extract_total_size),0.7,MyTxtColors,MyTxtShadow,__ACENTER)

	TiempoExtract = tiempo:time()/1000
	VelocidadExtract = (extract_total_write/1024)/TiempoExtract
	Tamano = extract_total_size/1024

	screen.print(151,175,string.format("%.2f",VelocidadExtract).."KB/s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.print(327,175,string.format("%.2f",(Tamano/VelocidadExtract)-TiempoExtract).."s",0.6,color.new(255,255,255),color.new(0,0,0),512)
	screen.flip()
	if file == fileant then
		extract_total_write = extract_total_write + bytes - antbytes
	else
		extract_total_write = extract_total_write + bytes
	end
	antbytes = bytes
	fileant = file
end 
-- ## Callback Nulo o Vacio ##
function CB_Dl_Null()
end


-- ## Vote Content ##
ScoreLevel = 5
function send_vote(x1,y1,x2,y2)
	screen.print(x1,y1,lang.trank,0.6,color.white,color.black,512) -- titulo
	screen.print(x1,100,lang.lrank[ScoreLevel+1],0.6,color.white,color.black,512) -- descripcion score
	icon.stars:blitsprite(188,120,ScoreLevel) -- sprite stars
	screen.print(x1,150,ScoreLevel.." - 5",0.6,color.white,color.black,512) -- comparacion score
	screen.print(151,175,"X: "..lang.srank,0.6,color.white,color.black,512)
	screen.print(327,175,"O: "..lang.crank,0.6,color.white,color.black,512)
	if (buttons.left or buttons.down) and ScoreLevel > 0 then
		ScoreLevel = ScoreLevel - 1
	end
	if (buttons.right or buttons.up) and ScoreLevel < 5 then
		ScoreLevel = ScoreLevel + 1
	end
	if buttons.circle then
		ScoreLevel = 5
		box.close()
	end
	if buttons.cross then
		if wlan.isconnected() then
			onNetGetFile = CB_Dl_Null -- callback nulo para evitar errores graficos
			http.post(Servidor.."ranking.php","id="..Lista[OverCat][scroll[3].sel].id.."&".."vote="..ScoreLevel) 
			if not RankList[Lista[OverCat][scroll[3].sel].id] then RankList[Lista[OverCat][scroll[3].sel].id] = {media = 0, puntos = 0, votos = 0,down = 0} end
			RankList[Lista[OverCat][scroll[3].sel].id].votos = RankList[Lista[OverCat][scroll[3].sel].id].votos + 1
			RankList[Lista[OverCat][scroll[3].sel].id].puntos = RankList[Lista[OverCat][scroll[3].sel].id].puntos + ScoreLevel
			RankList[Lista[OverCat][scroll[3].sel].id].media = math.floor(RankList[Lista[OverCat][scroll[3].sel].id].puntos/RankList[Lista[OverCat][scroll[3].sel].id].votos)
			ini.save("ms0:/oneinstaller/tmp/ranking.lua", RankList)
		end
		ScoreLevel = 5
		box.close()
	end
end
-- About efect 
function about(intxt)
	if not intxt then
		return 
	end

	amg.init() -- iniciamos el 3D
	screen.bilinear(1) -- activamos el suavizado de imgs
	local recursos = {
	crono =0,
	angle = 0,
	ct = 0,
	tbpos1 = -6,
	tbpos2 = -18,
	fxa = 255
	}
	--Ajustamos Textos
	local showtxt = ""
	for i=1,#intxt do
		if type(intxt[i]) == "string" then
			showtxt = showtxt..wordwrap(intxt[i],240,0.7)
		else
			for u=1,#intxt[i] do intxt[i][u] = wordwrap(intxt[i][u],240,0.7) end
			showtxt = showtxt..string.rep("\n",6)..string.implode(intxt[i], "\n")
		end
	end
	-- Cargamos Objetos 
	recursos.pboard = model3d.load("system/theme/3d/pboard.obj")--PSP_Board
	recursos.tpboard = texture3d.load("system/theme/3d/pboard.png",__VRAM)--PSP_B 
	texture3d.setmulti(recursos.pboard,1,1,recursos.tpboard)-- aplicamos la textura a el modelo
	model3d.lighting(recursos.pboard,1,0) -- indica que no afectara las luces a ese modelo
	recursos.env = model3d.load("system/theme/3d/penv.obj")--PSP_ENV
	texture3d.mapping(recursos.env,1,1,__ENV,2,3) -- ajusta la textura de ese obj a ambiental 
	model3d.lighting(recursos.env,1,0)-- indica que no afectara las luces a ese modelo
	--Creamos & ajustamos una camara
	camera1 = cam3d.new()
	cam3d.position(camera1,{0,0,1}) -- set posicion
	cam3d.eye(camera1,{0,0,0}) -- set vista
	--Ajustamos algunos parametros del escenario
	amg.perspective(35.0) -- ajusta el campo de vista
	amg.typelight(1,__DIRECTIONAL) -- ajusta luces direccionales
	amg.colorlight(1,color.new(250,250,250),color.new(100,200,90),color.new(120,120,120)) --ajusta colores de luces
	amg.poslight(1,{1,1,1}) --ajusta posicion de las luces
	amg.perspective(45.0)-- ajusta el campo de vista
	themesound = sound.load("system/sounds/theme.mp3")
	themesound:play()
	y = 232
	while true do--Inicia bucle principal de animacion
		buttons.read()
		--if buttons.start then err() end -- error ocacional
		if buttons.held.up then y = y - 6 end
		if buttons.held.down then y = y + 6 end
		amg.begin()
		screen.clear(color.new(255,255,255))
		cam3d.set(camera1)
		if recursos.crono < 500 or (recursos.crono > 1000 and recursos.crono < 1500) then
			cam3d.position(camera1,{0,0,1})
			cam3d.eye(camera1,{0,0,0})
		end	
		if recursos.crono == 500 or recursos.crono == 1000 or recursos.crono == 1500 or recursos.crono == 2000 then recursos.fxa = 255 end
		if (recursos.crono > 500 and recursos.crono < 1000) or recursos.crono > 1500 then
			cam3d.eye(camera1,{math.sin(recursos.ct),0,0})
		end
		amg.fog(3,12,color.new(255,255,255))
		amg.light(1,1);
		model3d.position(recursos.pboard,1,{0,0,recursos.tbpos1}) 
		model3d.render(recursos.pboard);
		model3d.position(recursos.pboard,1,{0,0,recursos.tbpos2}) 
		model3d.render(recursos.pboard);
		model3d.position(recursos.env,1,{0,0,recursos.tbpos1})
		model3d.render(recursos.env);
		model3d.position(recursos.env,1,{0,0,recursos.tbpos2}) 
		model3d.render(recursos.env);
		amg.light(1,0);
		amg.fog()
		amg.mode2d(1)
		--screen.print(10,10,"fps:"..screen.fps().."\n".."Y:"..y.."\nCrono:"..recursos.crono)
		screen.clip(110,20,260,232)
		screen.print(120,y,showtxt,0.7,color.new(250,250,250),color.new(25,25,25))
		screen.clip()
		screen.print(200+(100*math.sin(recursos.angle/30)),6,"OneInstaller",0.7,color.new(250,250,250),color.new(25,25,25))
		if y < -850 then --break
			screen.print(360,255,"O: Continue",0.7,color.new(250,250,250),color.new(25,25,25),__ACENTER)
			screen.print(120,255,"X: Continue",0.7,color.new(250,250,250),color.new(25,25,25),__ACENTER)
		end
		draw.fillrect(0,0,480,272,color.new(255,255,255,recursos.fxa))
		amg.mode2d(0)
		amg.update()	
		screen.flip()

		model3d.rotation(recursos.pboard,1,{0,0,recursos.angle/3}) 
		model3d.rotation(recursos.env,1,{0,0,recursos.angle/3}) 
		recursos.angle = recursos.angle - 1;	

		texture3d.trans(recursos.pboard,1,1,recursos.ct,0)	
		texture3d.envmap(recursos.env,1,1,0,0,recursos.angle/100)
		recursos.ct = recursos.ct + 0.008 
		recursos.fxa = recursos.fxa - 6
		if recursos.tbpos1 > 8 then recursos.tbpos1 = -16 end
		if recursos.tbpos2 > 8 then recursos.tbpos2 = -16 end
		recursos.tbpos1 = recursos.tbpos1 + 0.02;
		recursos.tbpos2 = recursos.tbpos2 + 0.02;
	
		recursos.crono = recursos.crono + 1;
		y = y - 0.5
		if buttons.cross or buttons.circle then break end
	end
	themesound:stop()
	showtxt = nil --libero el texto
	themesound = nil -- libero musica
	recursos = nil --libero todo lo demas.
	collectgarbage() 
	screen.bilinear(0) -- Quita el filtro suavizado
	amg.finish() -- cierra el 3D
end

-- explorer --
strings = { 
-- ## Opciones del Menu Explorer ##
back=" Return ",
copyfile="Copying File : ",
label="Waiting...\nLoading Image...",
dir="<DIR>",
copy = "Copy",
delete = "Delete ",
makedir = "MakeDir",
rename = "Rename",
extract = "Extract",
cancel = "Cancel",
extractto = "Extract To",
paste = "Paste",
move = "Move",
pass="Use Pass ?",
creatfolder="Create Folder",
newfolder="New Folder",
ospass="PASS",
}

-- ## Muestra Un texto mientras algo se carga 'LABEL' ## --
function label(txt) -- mensaje de loading resource
	local scrback = screen.buffertoimage()
	draw.fillrect(180,100,120,72,color.new(128,128,128,150))
	draw.rect(180,100,120,72,color.black)
	screen.print(240,120,txt,0.6,color.white,color.black,512)
	screen.flip()
	scrback:blit(0,0)
end

-- ## Visor De imagenes ## --
function visorimg(path,title) -- Version simplificada del visor del shell
	local scrback = screen.buffertoimage()
	local tmp = nil
	local _vmod = 0
	if type(path) == "string" then
		label(strings.label)
		tmp = image.load(path)
		_vmod = 1
	else
		tmp = path
	end
	if tmp then
		local infoimg = {}
		if _vmod == 0 then
			infoimg.name = title or ""
		else
			infoimg.name = files.nopath(path)
		end
		infoimg.w,infoimg.h = image.getrealw(tmp),image.getrealh(tmp)
		local show_bar_upper = true
		tmp:center()
		for i=0,20,1 do
			tmp:blit(240,136)
			draw.fillrect(0,0,480,i,color.new(255,255,255,100))
			screen.flip() 
		end
		while true do
			buttons.read()
			tmp:blit(240,136)
			if show_bar_upper then
				draw.fillrect(0,0,480,20,color.new(255,255,255,100))
				screen.print(10,3,infoimg.name,0.7,color.white,color.black)
				screen.print(420,3,"w:"..infoimg.w,0.7,color.white,color.black,__ARIGHT)
				screen.print(470,3,"h:"..infoimg.h,0.7,color.white,color.black,__ARIGHT)
			end
			screen.flip() 
			if buttons.square then show_bar_upper = not show_bar_upper end
			if buttons.circle or buttons.cross then
				break
			end
		end
		if show_bar_upper then
			for i=20,0,-1 do
				tmp:blit(240,136)
					draw.fillrect(0,0,480,i,color.new(255,255,255,100))
				screen.flip() 
			end
		end
		tmp = nil
		collectgarbage("collect")
	end
	scrback:blit(0,0)
end

-- ## Sort Add List By Name ##
function Sort_By(tab,tipo) -- pendiente este permitira varios ordenes
	
end

function files.listsort(path)
	local tmp1 = files.listdirs(path)
	if tmp1 then 
		table.sort(tmp1,function(a,b) return string.lower(a.name)<string.lower(b.name) end)
	else
		tmp1 = {}
	end
	local tmp2 = files.listfiles(path) 
	if tmp2 then
		table.sort(tmp2,function(a,b) return string.lower(a.name)<string.lower(b.name) end)
		for s,t in pairs(tmp2) do
			t.size = files.sizeformat(t.size)
			table.insert(tmp1,t)-- esto es por que son subtablas, realmente no puedo hacer un cont con tmp2
		end
	end
	return tmp1
end

-- ## Explorador ## --
explorer = {} -- All explorer functions
	-- index para scroll
	-- 6: Lista
	-- 7: Menu
	-- x para el plugman revisar --
	
-- ## Explorer Refresh ## --
function explorer.refresh()
explorer.list = files.listsort(Root[Dev])
scroll.set(6,explorer.list,15)
end

icons={1,pbp=2,prx=2,
png=3,gif=3,jpg=3,bmp=3,
mp3=4,s3m=4,wav=4,at3=4,
rar=5,zip=5,
cso=6,iso=6
}
-- ## Explorer Drawer List ## --
function explorer.listshow()
	local h=25
	local i = scroll[6].ini
	while i <= scroll[6].lim do --for i=scroll[6].ini,scroll[6].lim do -- Aunmento en un 75% de rendimiento al ser while
		if i==scroll[6].sel then draw.fillrect(0,h,480,15,color.new(128,128,128,100)) end
		--if explorer.list[i].size then
			--if icons[explorer.list[i].ext] then mimes:blitsprite(5,h, icons[explorer.list[i].ext])
		--	else mimes:blitsprite(5,h, 0) end
		--else
		--	mimes:blitsprite(5,h, 1)
		--end
		screen.print(25, h, explorer.list[i].name or "",0.6, isopened[explorer.list[i].ext] or color.white, color.black)
		screen.print(470, h, explorer.list[i].size or strings.dir, 0.6, color.white, color.black, __ARIGHT)
		h,i = h+15, i+1
	end
end

-- ## Explorer Drawer Menu ## --
function explorer.menushow()
	local h = slide_y + 5
	local i = scroll[7].ini
	while i <= scroll[7].lim do
		if i==scroll[7].sel then cc=color.new(255,130,0) else cc=color.white end
		screen.print(slide_x+45,h,slide_opts_txt[i],0.6,cc,color.black,512)
		h,i=h+15, i+1
	end	
end


isopened = { png = color.green, jpg = color.green, gif = color.green,
iso = color.orange, pbp = color.orange, cso = color.orange,zip = color.orange, rar = color.orange }

function refresh_opt()
	slide_open[2]=false
end

function copysrc()
	explorer.src = explorer.list[scroll[6].sel].path
	explorer.action = scroll[7].sel
	refresh_opt()
	scroll.set(7,slide_opts_txt,7)
end

function _refresh()
	explorer.refresh()
	refresh_opt()
	slide_opts_txt = {strings.copy,strings.move,strings.extract,strings.delete,strings.makedir,strings.rename,strings.cancel}
	scroll.set(7,slide_opts_txt,7)
	explorer.action = 0
	explorer.src, explorer.dst = "",""
end

function explorer.main()
	local scrback = screen.buffertoimage()
	Root = {"ms0:/","ef0:/"}
	if string.find(files.cdir(),"ef0") then Dev=2 else Dev=1 end

	back={}
	slide_open = {false,false} -- open/direction
	slide_x,slide_y,slide_h = 340,130,0
	slide_opts_txt = {strings.copy,strings.move,strings.extract,strings.delete,strings.makedir,strings.rename,strings.cancel}
	scroll.set(7,slide_opts_txt,7)
	explorer.refresh()
	explorer.src,explorer.dst = "",""
	explorer.action = 0
	divsect = 1
	while true do
		buttons.read()
		if background then background:blit(0,0)	end
		if divsect == 1 then -- List
			show_explorer_list() -- regla siempre el draw
			ctrls_explorer_list()
			if buttons.triangle then
				BackExpl = screen.buffertoimage()
				divsect, slide_open = 2, {true,true}
			end
		elseif divsect == 2 then -- Menu
			if BackExpl then BackExpl:blit(0,0) end
			show_explorer_menu() -- correccion igual para el draw list
			if slide_h > 100 then ctrls_explorer_menu() end -- evita uso de controles si se esta abriendo o cerrando
			if buttons.triangle or buttons.circle then refresh_opt() end
		end
		screen.flip()
		if buttons.select and not slide_open[2] then -- Salimos del explorer
			explorer.list=nil
			break
		end
	end
	scrback:blit(0,0)
end
	
function ctrls_explorer_list()

	if buttons.circle then -- return directory
		Root[Dev]=files.nofile(Root[Dev])
		explorer.refresh()
		if #back>0 then
			if scroll[6].maxim == back[#back].maxim then
				scroll[6]=back[#back]
			end
			back[#back] = nil
		end
	end

	if scroll[6].maxim > 0 then-- Is exists any?
		if buttons.up or buttons.held.l then scroll.up(6) end
		if buttons.down or buttons.held.r then scroll.down(6) end
		if buttons.cross then -- Avanzar o ejecutar
			local extension = explorer.list[scroll[6].sel].ext
			if extension == "png" or extension == "jpg" or extension == "gif" then
				visorimg(explorer.list[scroll[6].sel].path)
			elseif extension == "cso" or extension == "iso" or extension == "pbp" or extension == "bin" then
				if (extension == "cso" or extension == "iso") and os.cfw()~="VHBL" then
					game.launch(explorer.list[scroll[6].sel].path)
				end
				if (extension == "pbp") then game.launch(explorer.list[scroll[6].sel].path) end
			end
			if not explorer.list[scroll[6].sel].size then -- es un dir
				table.insert(back,scroll[6])
				Root[Dev]=explorer.list[scroll[6].sel].path
				explorer.refresh()
			end
		end
	end
	if buttons.start and not slide_open[2] then -- Swicht device
		if Dev == 1 and files.exists("ef0:/") then
			Dev = 2
			explorer.refresh()
		elseif Dev == 2 and files.exists("ms0:/") then
			Dev = 1
			explorer.refresh()
		end
	end
end

function show_explorer_list()
	draw.fillrect(0,0,480,20,barcolor)
	draw.fillrect(0,252,480,20,barcolor)
	screen.print(5,5,Root[Dev],0.6,color.new(255,69,0),color.black)
	if scroll[6].maxim > 0 then 
		if scroll[6].maxim> 15 then -- esto dibuja la barra de scroll :D
			local pos_height = math.max(225/scroll[6].maxim, 15)
			draw.fillrect(475, 25, 5, 225, color.new(255,255,255,100))
			draw.fillrect(475, 25+((225-pos_height)/(scroll[6].maxim-1))*(scroll[6].sel-1), 5, pos_height, color.new(0,255,0))
		end
		explorer.listshow()
	else
		screen.print(10,25,"...".."\n"..strings.back,0.7,color.white,color.black)
	end
	screen.print(240,240,explorer.src or "",0.5,color.white,color.black,512)
	screen.print(240,250,explorer.dst or "",0.5,color.white,color.black,512)
end

function show_explorer_menu()
	if slide_open[2] and slide_h < 110 then slide_h = slide_h + 8 end
	if not slide_open[2] and slide_h > 0 then slide_h = slide_h - 8 end
	if not slide_open[2] and slide_h < 2 then slide_open[1] = false end
	if not slide_open[1] and slide_h < 2 then divsect = 1 end
	draw.fillrect(slide_x,slide_y,90,slide_h,color.new(255,255,255,100))
	if slide_h > 100 then explorer.menushow() end -- la pongo aqui pues de lo contrario no actuan los if´s
end

function ctrls_explorer_menu()
	if buttons.up or buttons.held.l then scroll.up(7) end
	if buttons.down or buttons.held.r then scroll.down(7) end
	if buttons.cross then
		local numerador = 0
		if explorer.src == "" and scroll[7].sel <= 3 then
			if #explorer.list > 0 then
				if scroll[7].sel == 1 or scroll[7].sel == 2 then		--Copy/Move
					slide_opts_txt = {strings.paste,strings.delete,strings.makedir,strings.rename,strings.cancel}
					copysrc()
				else													--Extract
					if explorer.list[scroll[6].sel].ext and (files.ext(explorer.list[scroll[6].sel].path):upper()=="ZIP" or
						files.ext(explorer.list[scroll[6].sel].path):upper()=="RAR") then
						slide_opts_txt = {strings.extractto,strings.delete,strings.makedir,strings.rename,strings.cancel}
						copysrc()
					end
				end
			end
		elseif string.len(explorer.src) > 0 then
			if scroll[7].sel == 1 then
				explorer.dst = Root[Dev].."/"..files.nopath(explorer.src)
				if Root[Dev]:sub(#Root[Dev]) == "/" then
					explorer.dst = Root[Dev]..files.nopath(explorer.src)	
				end
				local screenback = screen.buffertoimage()
				if explorer.action == 1 then							--Paste from Copy
					files.copy(explorer.src,explorer.dst)
					screenback:blit(0,0)
			elseif explorer.action == 2 then							--Paste from Move
				if hw.getmodel() == "Vita" then
					if files.copy(explorer.src,explorer.dst) == 1 and files.exists(explorer.dst) then
						files.delete(explorer.src)
					end
					screenback:blit(0,0)
				else
					files.move(explorer.src,explorer.dst)
				end
			elseif explorer.action == 3 then							--Extract
				explorer.dst = files.nofile(explorer.dst)-- esto es por que añado el src al final, para move y copy
				if os.message(strings.pass,1) == 1 then
					local pass = osk.init(strings.ospass,"")
					if pass then files.extract_w_bar(explorer.src,explorer.dst,pass) end
					else
						files.extract_w_bar(explorer.src,explorer.dst)
					end
					screenback:blit(0,0)
				end
				_refresh()
			end
			numerador = 2
		end -- end of string len

		if scroll[7].sel == (4 - numerador) and #explorer.list > 0 then	--Delete
			if os.message(strings.delete..explorer.list[scroll[6].sel].name.."?",1) == 1 then
				files.delete(explorer.list[scroll[6].sel].path)
				_refresh()
			end
		end
		if scroll[7].sel == (5 - numerador) then						--MakeDir
			local newfolder = osk.init(strings.creatfolder, strings.newfolder)
			if newfolder then
				local dest = Root[Dev].."/"..newfolder
				if Root[Dev]:sub(#Root[Dev]) == "/" then dest = Root[Dev]..newfolder end
				files.mkdir(dest)
				_refresh()
			end
		end
		if scroll[7].sel == (6 - numerador) and #explorer.list > 0 then	--Rename
			local name = osk.init(strings.rename,files.nopath(explorer.list[scroll[6].sel].path))
			if name then
				files.rename(explorer.list[scroll[6].sel].path, name)
				_refresh()
			end
		end
		if scroll[7].sel == (7-numerador) then							--Cancel
			_refresh()
		end
	end--if buttons.cross
end