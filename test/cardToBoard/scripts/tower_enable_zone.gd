extends Area2D

@export var HighLightArea : MeshInstance2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	HighLightArea.hide()

	monitoring = true
	input_pickable = true
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	print(body)


func _on_mouse_entered() -> void:
	
	HighLightArea.show()


func _on_mouse_exited() -> void:
	HighLightArea.hide()