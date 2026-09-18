extends Node

@onready var menu := $Menu

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		esconder()
		alternar_pausa_por_grupo()
		get_viewport().set_input_as_handled()

func alternar_pausa_por_grupo() -> void:
	for nodo in get_tree().get_nodes_in_group("pausables"):
		if nodo.process_mode == Node.PROCESS_MODE_INHERIT:
			nodo.process_mode = Node.PROCESS_MODE_DISABLED 
		else:
			nodo.process_mode = Node.PROCESS_MODE_INHERIT 


func esconder() -> void:
	if is_instance_valid(menu):
		menu.visible = not menu.visible
