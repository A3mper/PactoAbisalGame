extends Node2D
@onready var intro_music_000 = $IntroMusic000
@export var Menu : Node2D
@export var Creditos : Node2D
@export var stopMenuMusic = false
@onready var in_button_to_pitch = $InButtonToPitch
@onready var start_game_sfx_000 = $StartGameSfx000
@onready var in_menu_sfx_000 = $InMenuSfx000

func _process(_delta):
	if stopMenuMusic:
		intro_music_000.stop()

func _on_salir_pressed() -> void:
	get_tree().quit()


func _on_creditos_pressed() -> void:
	in_button_to_pitch.pitch_scale = 2.27
	in_button_to_pitch.play()
	Menu.hide()
	Creditos.show()

func _on_iniciar_pressed() -> void:
	start_game_sfx_000.play()
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://tutorial.tscn")


func _on_iniciar_mouse_entered():
	in_menu_sfx_000.play()
	pass # Replace with function body.
	
func _on_creditos_mouse_entered():
	in_menu_sfx_000.play()
	pass # Replace with function body.


func _on_salir_mouse_entered():
	in_menu_sfx_000.play()
	pass # Replace with function body.

func _on_volver_de_creditos_pressed():
	in_button_to_pitch.pitch_scale = 2.27
	in_button_to_pitch.play()
	Menu.show()
	Creditos.hide()
	pass # Replace with function body.


func _on_volver_de_creditos_mouse_entered():
	in_menu_sfx_000.play()
	pass # Replace with function body.
