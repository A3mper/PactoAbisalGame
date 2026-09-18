extends Node

@onready var radiant_layer = $Audio/Musica/radiantLayer
@onready var void_layer = $Audio/Musica/voidLayer
@onready var animation_player = $AnimationPlayer
@onready var menu = $pausa/Menu
var zoom_speed_keyboard: float = 0.5  
var zoom_speed_mouse: float = 0.1    
 
signal torre_count_updated(valor : int)

var torreCount : int = 0



func _ready() -> void:
	menu.stopMenuMusic = true
	void_layer.volume_db = -80
	radiant_layer.volume_db = 0
	torreCountManager(0)

func _on_radiant_layer_finished():
	$Audio/Musica/RadiantLoopSegMusic001.play()
	pass # Replace with function body.


func _on_void_layer_finished():
	$Audio/Musica/VoidLoopSegMusic001.play()
	pass # Replace with function body.

func _on_torre_desinstalada() -> void:
	torreCountManager(-1)

func _on_torre_instalada() -> void:
	torreCountManager(+1)

func torreCountManager(nuevo :int)->void:
	torreCount += nuevo
	if torreCount < 0:
		torreCount = 0
	torre_count_updated.emit(torreCount)
	
	

func _on_game_over() -> void:
	get_tree().change_scene_to_file("res://test/cardToBoard/scenes/game_over.tscn")
