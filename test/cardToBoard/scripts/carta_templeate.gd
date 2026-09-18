extends Node2D

@export var DimensionesButton : Button

var Size_X : float = 0.0
var Size_Y : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Size_X = DimensionesButton.size.x
	Size_Y = DimensionesButton.size.y

func get_size_x()->float:
	return Size_X
	
func get_size_y()->float:
	return Size_Y
