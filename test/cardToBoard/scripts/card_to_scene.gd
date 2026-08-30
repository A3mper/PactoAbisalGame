extends Node2D



#const t_e_z := preload("uid://cd1wmsbvp3das")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _on_game_over() -> void:
	get_tree().paused = true
	print("gay over")
