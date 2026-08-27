extends Node2D

@export var PNGMania : Sprite2D
@export var LeBalaPS : PackedScene
@export var SalidaBala : Marker2D
@export var timer : Timer

var IsPlaced : bool = true
var HasTarget : bool = false
var IsReadyShoot : bool = true

var leemeEsta : Node2D = null
var Bala : Node2D

func _ready():
	PNGMania.self_modulate.a = 0.25
	

func _on_tree_exited() -> void:
	queue_free()

func _on_plant() -> void:
	IsPlaced = true
	PNGMania.self_modulate.a = 1

func dispara():
	if IsReadyShoot:
		Bala = LeBalaPS.instantiate()
		SalidaBala.add_child(Bala)
		timer.start()
		IsReadyShoot = false

func _process(_delta : float):
	if IsPlaced:
		if HasTarget:
			'''
			print(leemeEsta.global_position,"  -  ",global_position)
			print(leemeEsta.global_position - global_position)
			print(rad_to_deg(atan2(leemeEsta.global_position.y - global_position.y,leemeEsta.global_position.x - global_position.x)))
			'''
			SalidaBala.rotation = atan2(leemeEsta.global_position.y - global_position.y,leemeEsta.global_position.x - global_position.x)
			dispara()
				

func _on_area_2d_body_entered(_body: Node2D) -> void:
	HasTarget = true
	print("c papu")
	leemeEsta = _body
	


func _on_area_2d_body_exited(_body: Node2D) -> void:
	HasTarget = false
	leemeEsta = null


func _on_cad_de_fuego_timeout() -> void:
	IsReadyShoot = true
