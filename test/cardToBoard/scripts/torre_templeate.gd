extends StaticBody2D

@export var PNGMania : Sprite2D

func _ready():
	PNGMania.self_modulate.a = 0.25

func _on_tree_exited() -> void:
	queue_free()

func _on_plant() -> void:
	PNGMania.self_modulate.a = 1