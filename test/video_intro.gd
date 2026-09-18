extends Node2D

func _ready():
	$EidolonsTalkThemeMusic000.play()
	
func _go_to_play() -> void:
	get_tree().change_scene_to_file("res://test/cardToBoard/scenes/cardToScene.tscn")
