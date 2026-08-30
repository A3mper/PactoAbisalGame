extends Node2D

@export var ogvPlayer : VideoStreamPlayer

func _on_video_stream_player_finished() -> void:
	# Pausamos la ejecución hasta que la transición termine
	await fade()
	# Una vez terminado el desvanecimiento, liberamos el nodo
	queue_free()    

func fade() -> Signal:
	var tween := create_tween()
	
	# Transición de opaco a transparente en 1.5 segundos
	# Usamos 'modulate' para afectar al nodo y sus componentes
	tween.tween_property(ogvPlayer, "modulate", Color.TRANSPARENT, 1.5)
	
	# Retornamos la señal 'finished' del Tween para poder usar 'await'
	return tween.finished