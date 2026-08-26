extends Node2D

@export var torre_a_colocar : PackedScene
#@export var ZonaTorre : Area2D

var Torre : Node2D = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED
	#ZonaTorre.monitoring = true
	Torre = torre_a_colocar.instantiate()
	'''
	if Torre != null:
		ZonaTorre.add_child(Torre)
	
	pass # Replace with function body.
	'''

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:

	Torre.global_position = get_global_mouse_position()
	

	
