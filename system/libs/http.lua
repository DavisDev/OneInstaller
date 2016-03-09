--Lib Http 
http = {}
function http.savefile(Url,path,debug)
	if wlan.isconnected() == false then return nil end
	file = io.open(path,"wb")
 	local w,x = string.find(Url, "/",8,true)
	local host = string.sub(Url, 8, w-1)
	local file_link = string.sub(Url, w)
	local Mysocket = socket.connect(host,80) -- Conectamos al servidor
	if debug then screen.print(10,10,"Puerto Abierto") screen.flip() end
	os.delay(50)
	Mysocket:send("GET "..file_link.." HTTP/1.1\r\n".."host: "..host.."\r\n")-- Pedimos el archivo
	Mysocket:send("User-Agent: OneLua/v2r1\r\n\r\n") -- Enviamos Desde que pedimos
	if debug then screen.print(10,10,"Peticion Enviada") screen.flip()	end
	os.delay(50)
	local header = http.read.header(Mysocket,debug) -- Obtenemos el header
	if header == nil then -- Si esto sucede ya valio xD
		file:close()
		Mysocket:close()
		return nil	
	end
	local code = http.read.code(header)
	if code == false then -- Si esto no es 200 ya valio
		file:close()
		Mysocket:close()
		return nil
	end
	local encoded = http.read.encoded(header)
	if encoded then -- Si esto es true ya valio, pero reintentamos
		file:close()
		Mysocket:close()
		return http.savefile(Url,path,debug)
	end
	local size = http.read.size(header)
	if debug then
		screen.print(10,30,"Size:"..tostring(size).."Bytes")
		screen.flip()
	end
	
	-- Escribimos xD
	local timeout = timer.new()
	local running = true
	local readbytes, writen = 0,0
	local readdata, data = "",""
	local result = true
	while writen < size do
	    readdata,readbytes = Mysocket:recv(8192)
		if readdata ~= "" then
			timeout:stop()
			file:write(readdata)
			writen = writen + readbytes
			onNetGetFile(size, writen)
		else
			timeout:start()
		end
		if readdata == "" and timeout:time() < 500 then
			os.delay(5)
		elseif readdata == "" and timeout:time() == 1300 then
		   result = false
		   break
		end
	 end
	file:flush()
	file:close()
	Mysocket:close()
	return result
end
function http.image(Url,tipo,debug)
	if wlan.isconnected() == false then return nil end
	if tipo == nil then	tipo = 0 end
	local data = http.get(Url,debug)
	if data then
		return image.loadfromdata(data,tipo)
	end
	return nil
end
function http.postsave(Url,datapost,path,debug)
	if wlan.isconnected() == false then return nil end
 	local w,x = string.find(Url, "/",8,true)
	local host = string.sub(Url, 8, w-1)
	local form = string.sub(Url, w)
	local Mysocket = socket.connect(host,80) -- Conectamos al servidor
	if debug then screen.print(10,10,"Puerto Abierto") screen.flip() end
	os.delay(50)
	Mysocket:send("POST "..form.." HTTP/1.1\r\n".."host: "..host.."\r\n") --Enviamos data al servidor
	Mysocket:send("Content-Type: application/x-www-form-urlencoded\r\n")
	Mysocket:send("Content-Length: "..string.len(datapost).."\r\n\r\n")
	Mysocket:send(datapost.."\r\n")
	if debug then screen.print(10,10,"Post Enviada") screen.flip()	end
	os.delay(50)
	local header = http.read.header(Mysocket,debug) -- Obtenemos el header
	if header == nil then -- Si esto sucede ya valio xD
		Mysocket:close()
		return nil	
	end
	local code = http.read.code(header)
	if code == false then -- Si esto no es 200 ya valio
		Mysocket:close()
		return nil
	end
	local encoded = http.read.encoded(header)
	if encoded then -- Si esto es true ya valio, pero reintentamos
		Mysocket:close()
		return http.postsave(Url,datapost,path,debug)
	end
	local size = http.read.size(header)
	if debug then
		screen.print(10,30,"Size:"..tostring(size).."Bytes")
		screen.flip()
	end
	file = io.open(path,"wb")
		-- Escribimos xD
	local timeout = timer.new()
	local running = true
	local readbytes, writen = 0,0
	local readdata, data = "",""
	local result = true
	while writen < size do
	    readdata,readbytes = Mysocket:recv(8192)
		if readdata ~= "" then
			timeout:stop()
			file:write(readdata)
			writen = writen + readbytes
			onNetGetFile(size, writen)
		else
			timeout:start()
		end
		if readdata == "" and timeout:time() < 500 then
			os.delay(5)
		elseif readdata == "" and timeout:time() == 1300 then
		   result = false
		   break
		end
	 end
	file:flush()
	file:close()
	Mysocket:close()
	return result
end
function http.post(Url,datapost,retry,debug)
	if wlan.isconnected() == false then return nil end
 	local w,x = string.find(Url, "/",8,true)
	local host = string.sub(Url, 8, w-1)
	local form = string.sub(Url, w)
	local Mysocket = socket.connect(host,80) -- Conectamos al servidor
	if debug then screen.print(10,10,"Puerto Abierto") screen.flip() end
	os.delay(50)
	Mysocket:send("POST "..form.." HTTP/1.1\r\n".."host: "..host.."\r\n") --Enviamos data al servidor
	Mysocket:send("Content-Type: application/x-www-form-urlencoded\r\n")
	Mysocket:send("Content-Length: "..string.len(datapost).."\r\n\r\n")
	Mysocket:send(datapost.."\r\n")
	if debug then screen.print(10,10,"Post Enviada") screen.flip()	end
	os.delay(50)
	local header = http.read.header(Mysocket,debug) -- Obtenemos el header
	if header == nil then -- Si esto sucede ya valio xD
		Mysocket:close()
		return nil	
	end
	local code = http.read.code(header)
	if code == false then -- Si esto no es 200 ya valio
		Mysocket:close()
		return nil
	end
	local encoded = http.read.encoded(header)
	if encoded and retry then -- Si esto es true ya valio, pero reintentamos
		Mysocket:close()
		return http.post(Url,datapost,debug)
	end
	local size = http.read.size(header)
	if debug then
		screen.print(10,30,"Size:"..tostring(size).."Bytes")
		screen.flip()
	end
	local data = http.read.data(Mysocket,size,debug)
	Mysocket:close()
	return data
end
function http.get(Url,debug)
	if wlan.isconnected() == false then return nil end
 	local w,x = string.find(Url, "/",8,true)
	local host = string.sub(Url, 8, w-1)
	local file_link = string.sub(Url, w)
	local Mysocket = socket.connect(host,80) -- Conectamos al servidor
	if debug then screen.print(10,10,"Puerto Abierto") screen.flip() end
	os.delay(50)
	Mysocket:send("GET "..file_link.." HTTP/1.1\r\n".."host: "..host.."\r\n\r\n") -- Pedimos el archivo
	if debug then screen.print(10,10,"Peticion Enviada") screen.flip()	end
	os.delay(50)
	local header = http.read.header(Mysocket,debug) -- Obtenemos el header
	if header == nil then -- Si esto sucede ya valio xD
		Mysocket:close()
		return nil	
	end
	local code = http.read.code(header)
	if code == false then -- Si esto no es 200 ya valio
		Mysocket:close()
		return nil
	end
	local encoded = http.read.encoded(header)
	if encoded then -- Si esto es true ya valio, pero reintentamos
		Mysocket:close()
		return http.get(Url,debug)
	end
	local size = http.read.size(header)
	if debug then
		screen.print(10,30,"Size:"..tostring(size).."Bytes")
		screen.flip()
	end
	local data = http.read.data(Mysocket,size,debug)
	Mysocket:close()
	return data
end
http.read = {}
function http.read.header(sock,debug)
	local timeout = timer.new()
	timeout:start()
	local running = true
	local header = ""
	while running do -- Obtenemos la cabecera
	    header = header..sock:recv(1)
		if debug then
			screen.print(10,10,header)
			screen.flip()
		end
	    if header:find("\r\n\r\n") then 
			running = false
		elseif timeout:time() > 5000 then
			return nil
		end
    end
	return header
end
function http.read.data(sock,size,debug)
	local timeout = timer.new()
	local running = true
	local readbytes, writen = 0,0
	local readdata, data = "",""
	while writen < size do
	    readdata,readbytes = sock:recv(8192)
		if readdata ~= "" then
			timeout:stop()
			data = data..readdata
			writen = writen + readbytes
			onNetGetFile(size, writen)
		else
			timeout:start()
		end
		if readdata == "" and timeout:time() < 500 then
			os.delay(5)
		elseif readdata == "" and timeout:time() == 1300 then
		   running = false
		 end
	 end
	 return data
end
function http.read.code(header)
	local a,b,c,d
	a,b = string.find(header, "HTTP/1.1 200 OK",1,true)-- buscamos el Code del server
	if a then -- encontro el valor, lo obtenemos.
		return true
	end
		return false
end
function http.read.size(header)
	local a,b,c,d
	a,b = string.find(header, "Content-Length: ",1,true)-- buscamos el tamaño de la descarga
	if a then -- encontro el valor, lo obtenemos.
		c,d = string.find(header, "\r\n",b,true)
		return tonumber(string.sub(header, b, c))
	end
		return 0
end
function http.read.encoded(header)
	local a,b,c,d
	a,b = string.find(header, "Transfer-Encoding: chunked",1,true)-- buscamos el tamaño de la descarga
	if a then -- encontro el valor, lo obtenemos.
		return true
	end
		return false
end
--[[function http.read.data(sock,size,debug)
	local timeout = timer.new()
	local running = true
	local readbytes, writen = 0,0
	local readdata, data = "",""
	while running do
	    readdata,readbytes = sock:recv(1024)
		if readdata ~= "" then
			timeout:stop()
			data = data..readdata
			writen = writen + readbytes
			onNetGetFile(size, writen)
		else
			timeout:start()
		end
		if readdata == "" and timeout:time() < 500 then
			os.delay(5)
		elseif readdata == "" and timeout:time() == 1300 then
		   running = false
		 end
	 end
	 return data
end]]
--[[function http.decode(data)
	screen.print(10,10,data)
	screen.flip()
	buttons.waitforkey()
	--os.message(tostring(data))
	local a,b,c,d,e,f
	local tmp = ""
	local running = true
	a,b = string.find(data, "00",1,true)
	--b = 2
	while running do
		c,d = string.find(data, "\r\n",b,true)
		os.message(tostring(data:sub(b+1,c-1)))
		local leng = tonumber("0x"..data:sub(b+1,c-1))
		os.message(tostring(leng))
		d = (d + 1) - b
		b = b + d
		tmp = tmp..string.sub(data,b,leng+b)
		screen.print(10,10,tmp)
		screen.flip()
		buttons.waitforkey()
		os.message(string.sub(tmp,b,leng+b-400))
		b = b + leng + 2		-- al terminar el fragmento nos envia /r/n
		os.message(data:sub(b,data:len()).."Largo:"..data:len()-b)
		if data:sub(b,data:len()) == "0\r\n\r\n" then
			running = false
			return tmp
		end
	end
	return ""
end]]