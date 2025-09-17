
images = {} -- Lista de imágenes
start = 0	-- Variable de inicio del experimento

-- this function is called when the box is initialized
function initialize(box)
	io.write("initialize has been called\n");

	dofile(box:get_config("${Path_Data}") .. "/plugins/stimulation/lua-stimulator-stim-codes.lua")

	-- inspects the box topology
	io.write(string.format("box has %i input(s)\n", box:get_input_count()))
	io.write(string.format("box has %i output(s)\n", box:get_output_count()))
	io.write(string.format("box has %i setting(s)\n", box:get_setting_count()))
	for i = 1, box:get_setting_count() do
		io.write(string.format(" - setting %i has value [%s]\n", i, box:get_setting(i)))
	end
	
	-- images = {}
	for image=33025,33025+29 do table.insert(images , image) end	-- Se genera una tabla con la lista de imágenes
	-- for image=33025,33025+8 do table.insert(images , image) end
	
end

-- this function is called when the box is uninitialized
function uninitialize(box)
	io.write("uninitialize has been called\n")
end

-- this function is called once by the box
function process(box)
	io.write("process has been called\n")

	-- loop until box:keep_processing() returns zero
	-- cpu will be released with a call to sleep
	-- at the end of the loop
	while box:keep_processing() do

		-- gets current simulated time
		t = box:get_current_time()

		-- loops on all inputs of the box
		for input = 1, box:get_input_count() do

			-- loops on every received stimulation for a given input
			for stimulation = 1, box:get_stimulation_count(input) do

				-- gets the received stimulation
				identifier, date, duration = box:get_stimulation(input, 1)

				-- logs the received stimulation
				io.write(string.format("At time %f on input %i got stimulation id:%s date:%s duration:%s\n", t, input, identifier, date, duration))

				if identifier == 32792 then 		-- Condición inicial (Peresionar Enter para comenzar)
					start = 1
				end

				if start == 0 then					-- Se muestran las instrucciones antes del inicio del experimento
					identifier = 33024
				end
				
				if start == 1 then 					-- No se muestran las imágenes hasta que no se ha presionado Enter
					if identifier == 33282 then		-- Se recibe un estímulo de reloj (identifier = 33282)
						if #images == 0 then		-- Se han removido todas las imágenes de la lista
							identifier = 32792		-- Se envía un estímulo para borrar la pantalla (identifier = 33024)
						else
							identifier = table.remove(images,math.random(#images))	-- Se obtiene una imagen de la lista (aleatoriamente) y posteriormente se elimina de la misma
						end
					end
				end

				-- Prueba Franz Lake - Stimulus
				-- io.write(string.format("Este es el estímulo recibido %s\n", identifier))

				-- Prueba Franz Lake - Random number
				-- io.write(string.format("Esto es un numero aleatorio %i\n", math.random(100)))

				-- discards it
				box:remove_stimulation(input, 1)

				-- triggers a new OVTK_StimulationId_Label_00 stimulation five seconds after
				-- box:send_stimulation(1, OVTK_StimulationId_Label_00, t, 0)
				box:send_stimulation(1, identifier, t, 0)
			end
		end

		-- releases cpu
		box:sleep()
	end
end
