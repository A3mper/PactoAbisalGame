extends Node2D

# Opacidad normal
@export_range(0.0, 1.0) var normal_alpha: float = 1.0

# Opacidad cuando el mouse está encima
@export_range(0.0, 1.0) var hover_alpha: float = 0.35

# Velocidad de transición
@export var transition_speed: float = 10.0


var sprite_hover: Sprite2D = null


func _process(delta):

	var mouse_pos = get_global_mouse_position()

	# Buscar el Sprite2D que está debajo del mouse
	var nuevo_sprite = buscar_sprite_bajo_mouse(mouse_pos)

	sprite_hover = nuevo_sprite


	# Cambiar la opacidad de todos los sprites
	for child in get_children():

		if child is Sprite2D:

			var alpha_objetivo = normal_alpha

			if child == sprite_hover:
				alpha_objetivo = hover_alpha

			child.modulate.a = move_toward(
				child.modulate.a,
				alpha_objetivo,
				transition_speed * delta
			)


func buscar_sprite_bajo_mouse(mouse_pos: Vector2) -> Sprite2D:

	var sprites: Array[Sprite2D] = []


	# Obtener todos los Sprite2D hijos
	for child in get_children():

		if child is Sprite2D:
			sprites.append(child)


	# Ordenar según Z
	# El que tenga mayor Z queda adelante
	sprites.sort_custom(func(a, b):
		return a.z_index > b.z_index
	)


	# Revisar los sprites desde adelante hacia atrás
	for sprite in sprites:

		if sprite.texture == null:
			continue


		# Convertir la posición del mouse
		# al espacio local del Sprite2D
		var local_mouse = sprite.to_local(mouse_pos)


		# Tamaño de la textura
		var texture_size = sprite.texture.get_size()


		# Crear el rectángulo de la textura
		var rect = Rect2(
			-texture_size / 2.0,
			texture_size
		)


		# Si el Sprite2D NO está centrado
		if not sprite.centered:
			rect.position = Vector2.ZERO


		# Comprobar si el mouse está dentro
		if rect.has_point(local_mouse):

			return sprite


	# Ningún sprite debajo del mouse
	return null
