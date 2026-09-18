extends Node2D

@export var drag_speed: float = 1.0

# Límites horizontales
@export var min_x: float = -1000.0
@export var max_x: float = -45.0

# Límites verticales
@export var min_y: float = -80.0
@export var max_y: float = 100.0

var dragging: bool = false
var last_mouse_position: Vector2 = Vector2.ZERO


func _input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			dragging = event.pressed
			last_mouse_position = event.position


	if event is InputEventMouseMotion and dragging:

		var delta: Vector2 = event.position - last_mouse_position

		position.x += delta.x * drag_speed
		position.y += delta.y * drag_speed

		# Limitar movimiento horizontal
		position.x = clamp(position.x, min_x, max_x)

		# Limitar movimiento vertical
		position.y = clamp(position.y, min_y, max_y)

		last_mouse_position = event.position
