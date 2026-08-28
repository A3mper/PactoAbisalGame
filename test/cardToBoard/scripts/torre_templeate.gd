extends Node2D

@export var PNGMania : Sprite2D
@export var LeBalaPS : PackedScene
@export var SalidaBala : Marker2D
@export var rof : Timer

var IsPlaced : bool = false
var HasTarget : bool = false
var IsReadyShoot : bool = true

var enemyBody : Node2D = null
var Fogonazo : Node2D
	
var duracion_fogonazo: float = 0	

func _ready():
	PNGMania.self_modulate.a = 0.25
	Fogonazo = LeBalaPS.instantiate()
	SalidaBala.add_child(Fogonazo)
	Fogonazo.hide()

func _on_tree_exited() -> void:
	queue_free()

func _on_plant() -> void:
	IsPlaced = true
	PNGMania.self_modulate.a = 1
	

func dispara():
	if IsReadyShoot:
		IsReadyShoot = false
		
		Fogonazo.show()
		
		rof.start()

		duracion_fogonazo = rof.wait_time * 0.25

		get_tree().create_timer(duracion_fogonazo).timeout.connect(_on_fogonazo_timeout)
		

func _process(_delta : float):
	#print(IsPlaced,HasTarget,IsReadyShoot)
	if IsPlaced:
		if HasTarget:
			
			if enemyBody != null:
				SalidaBala.look_at(enemyBody.global_position)
				
			dispara()
				

func _on_area_2d_body_entered(_body: Node2D) -> void:
	HasTarget = true
	print("c papu")
	enemyBody = _body

func _on_area_2d_body_exited(_body: Node2D) -> void:
	HasTarget = false
	enemyBody = null


func _on_cad_de_fuego_timeout() -> void:
	IsReadyShoot = true

func _on_fogonazo_timeout():
	if is_instance_valid(Fogonazo): 
		Fogonazo.hide()
