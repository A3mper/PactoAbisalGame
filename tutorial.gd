extends Control

@onready var texture_rect: TextureRect = $TextureRect

# Configuración del tutorial
const RUTA_BASE = "res://assets/Images/Tutorial/paso_%d.jpg"
const TOTAL_PAGINAS = 24 # Cambia esto por el número total de tus imágenes

var pagina_actual: int = 0

func _ready() -> void:
	mostrar_pagina(pagina_actual)
	$Mtutorial.play()


func mostrar_pagina(num_pagina: int) -> void:
	# Construye la ruta de la imagen, ej: res://tutorial/paso_0.png
	var ruta_imagen = RUTA_BASE % num_pagina
	
	if ResourceLoader.exists(ruta_imagen):
		texture_rect.texture = load(ruta_imagen)
	else:
		push_error("No se encontró la imagen del tutorial en: " + ruta_imagen)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			avanzar_tutorial()
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			retroceder_tutorial()

func retroceder_tutorial() -> void:
	if pagina_actual > 0:
		pagina_actual -= 1
		mostrar_pagina(pagina_actual)


func avanzar_tutorial() -> void:
	pagina_actual += 1
	
	if pagina_actual < TOTAL_PAGINAS:
		mostrar_pagina(pagina_actual)
	else:
		finalizar_tutorial()

func finalizar_tutorial() -> void:
	print("¡Tutorial terminado!")
	# Aquí puedes ocultar la pantalla, cambiar de escena o activar el juego
	get_tree().change_scene_to_file("res://test/cardToBoard/scenes/cardToScene.tscn")
	queue_free() # Elimina la pantalla de tutorial de la memoria
