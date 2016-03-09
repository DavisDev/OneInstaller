- [[
	One Installer - The Wiki homebrews.
	Content Manager and Installer for PSP & PSVITA.
	Developed by Davis Nuñez in 2015 (c).
	
	Licensed by Creative Commons Attribution-ShareAlike 4.0
	http://creativecommons.org/licenses/by-sa/4.0/
	
	Bug Fix install plugins over ...
]]

os.cpu(333) -- Set CPU a maximo temporalmente.
dofile("system/libs/kernel.lua") -- libreria con la mayoria de funciones
function onDebug(msg) -- nuestro propio screen debug
	files.write("ms0:/oneinstaller/debug.txt",msg)
	usb.mstick  (  )
	os.message(msg)
	os.exit()
	--http.post(Servidor.."errorlog.php","username="..os.nick().."&".."lang="..os.language().."&".."model="..hw.getmodel().."&".."gen="..hw.gen().."&".."reg="..hw.region().."&".."fw="..os.cfw().."&".."bug="..msg)
end
kernel.loadscreen.set("system/theme/")--Cargamos el fondo para la loadscreen
kernel.loadscreen.fadein()
kernel.dofile("system/engine.lua") -- casi todo el app :D
kernel.loadscreen.fadeout()
--if not os.nick() == "PPSSPP" then --Solo Muestra el dialogo si es el PSP
	draw_back(true)
	wlan.connect() --Dialogo de conexion a internet
--end
Servidor = "http://devonelua.x10.mx/oneinstaller/"
barcolor = MyBarColors[config[1]] -- configuracion 1 en el ini
Update_Core() -- Carga o actualiza el core (repo&rank&tops)
Seccion = 1
while true do
	buttons.read() -- Leemos los botones
	barcolor = MyBarColors[config[1]] -- configuracion 2 en el ini
	osc.run()
	--if buttons.start then usb.mstick  (  ) box.new("Enable Debug Mode","Usb Activado") os.restart()  end
	--if buttons.select then os.restart()  end
	if Seccion == 1 then -- menu
		show_menu()
		ctrls_menu()
	elseif Seccion == 2 then -- cats
		show_cats()
		ctrls_cats()
	elseif Seccion == 3 then -- list
		show_ltcnt()
		ctrls_ltcnt()
	elseif Seccion == 4 then -- view
		show_vrcnt()
		ctrls_vrcnt()
	elseif Seccion == 5 then -- ScreenShots
		show_shots()
		ctrls_shots()
	elseif Seccion == 6  then -- View Comments
		show_viewcomments()
		ctrls_viewcomments()
	elseif Seccion == 7  then -- New Comment
		show_formcomments()
		ctrls_formcomments()
	elseif Seccion == 8  then -- Configurados
		show_configs()
		ctrls_configs()
	end
	if buttons.triangle then box.api(api_homemenu,true)  end
	--screen.print(10,20,"Fps:"..screen.fps  (  ) )
	screen.flip()
	--collectgarbage("collect")
end
