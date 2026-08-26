extends Node2D

@export var TorreCorrespondiete : PackedScene
@export var TorreParent : Node

var Torre : Node2D = null
var IsTorreSelected : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Torre = TorreCorrespondiete.instantiate()
	pass # Replace with function body.

func _process(_delta: float) -> void:
	if IsTorreSelected:
		Torre.global_position = get_global_mouse_position()

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed: 
			IsTorreSelected = false
			TorreParent.remove_child(Torre)
			Torre = null
			
			

func _on_button_pressed() -> void:
	Torre = TorreCorrespondiete.instantiate()
	IsTorreSelected = true
	TorreParent.add_child(Torre)
