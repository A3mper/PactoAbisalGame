extends Node2D

@export var PNGMania : Sprite2D
@export var LeBalaPS : PackedScene
@export var SalidaBala : Marker2D
@export var rof : Timer
@export var AreaDeEfecto : Area2D

var IsPlaced : bool = false
#var HasTarget : bool = false
var IsReadyShoot : bool = true

var objetivoActual : Node2D = null
var objetivosEnRango : Array[Node2D] = []

var Fogonazo : Node2D

var dmgTorre : int = 50
var duracion_fogonazo: float = 0	

func _ready():
	AreaDeEfecto.monitoring = false
	PNGMania.self_modulate.a = 0.25
	Fogonazo = LeBalaPS.instantiate()
	SalidaBala.add_child(Fogonazo)
	Fogonazo.hide()

func _on_tree_exited() -> void:
	queue_free()

func _on_plant() -> void:
	IsPlaced = true
	AreaDeEfecto.monitoring = true
	PNGMania.self_modulate.a = 1
	

func dispara():
	if IsReadyShoot:
		
		IsReadyShoot = false
		
		Fogonazo.show()
		
		rof.start()

		duracion_fogonazo = rof.wait_time * 0.25

		get_tree().create_timer(duracion_fogonazo).timeout.connect(_on_fogonazo_timeout)

		if objetivoActual.has_method("has_been_shot"):
			
			objetivoActual.has_been_shot(dmgTorre)
		

func _process(_delta : float):
	

	if IsPlaced:
		ActualizarObjetivo()

		if objetivoActual != null:
			SalidaBala.look_at(objetivoActual.global_position)
			
			dispara()

func ActualizarObjetivo():
	objetivosEnRango = objetivosEnRango.filter(func(exist) : return is_instance_valid(exist))

	if objetivosEnRango.size() > 0:
		objetivoActual = objetivosEnRango[0]
	else:
		objetivoActual = null

func _on_area_2d_body_entered(_body: Node2D) -> void:
	
	#print("c papu")
	if _body.has_method("has_been_shot") and not objetivosEnRango.has(_body):
		objetivosEnRango.append(_body)

func _on_area_2d_body_exited(_body: Node2D) -> void:
	#HasTarget = false
	objetivoActual = null


func _on_cad_de_fuego_timeout() -> void:
	IsReadyShoot = true

func _on_fogonazo_timeout():
	if is_instance_valid(Fogonazo): 
		Fogonazo.hide()
