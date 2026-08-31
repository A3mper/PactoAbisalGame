extends Node

@export var volumen_bus_radiant: float = 0.0:
	set(valor):
		volumen_bus_radiant = valor
		# Buscamos el índice y aplicamos el cambio en vivo al AudioServer
		var idx = AudioServer.get_bus_index("RadiantLayer") # Cambia por el nombre real de tu bus
		if idx != -1:
			AudioServer.set_bus_volume_db(idx, valor)

@export var volumen_bus_void: float = -60.0:
	set(valor):
		volumen_bus_void = valor
		var idx = AudioServer.get_bus_index("VoidLayer") # Cambia por el nombre real de tu bus
		if idx != -1:
			AudioServer.set_bus_volume_db(idx, valor)
