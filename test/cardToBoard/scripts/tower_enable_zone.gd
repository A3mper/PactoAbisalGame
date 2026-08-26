extends Area2D

@export var HighLightArea : MeshInstance2D

signal _on_torre_zone_entered
signal _on_torre_zone_exited

var TorrePosActive : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	HighLightArea.hide()
	#monitoring = true
	input_pickable = true
	
'''
func _on_body_entered(body: Node2D) -> void:
	print(body)
'''

func _on_mouse_entered() -> void:
	if TorrePosActive:
		_on_torre_zone_entered.emit()
		HighLightArea.show()

func _on_mouse_exited() -> void:
	if TorrePosActive:
		_on_torre_zone_exited.emit()
		HighLightArea.hide()


func _on_torre_selected() -> void:
	TorrePosActive = true 

func _on_torre_de_selected() -> void:
	TorrePosActive = false
	HighLightArea.hide()
