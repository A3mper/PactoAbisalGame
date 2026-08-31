extends Node2D

@onready var radiant_layer = $Audio/Musica/radiantLayer
@onready var void_layer = $Audio/Musica/voidLayer
@onready var animation_player = $AnimationPlayer


#const t_e_z := preload("uid://cd1wmsbvp3das")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	void_layer.volume_db = -80
	radiant_layer.volume_db = 0
	print("Animaciones disponibles: ", animation_player.get_animation_list())
	pass
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED


func _on_game_over() -> void:
	get_tree().paused = true
	print("gay over")


func _on_radiant_layer_finished():
	$Audio/Musica/RadiantLoopSegMusic001.play()
	pass # Replace with function body.


func _on_void_layer_finished():
	$Audio/Musica/VoidLoopSegMusic001.play()
	pass # Replace with function body.
