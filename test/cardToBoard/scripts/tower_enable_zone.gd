extends Area2D

@export var HighLightArea : MeshInstance2D

signal _on_torre_zone_entered(zona:Area2D)
signal _on_torre_zone_exited(zona:Area2D)

var TorrePosActive : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	HighLightArea.hide()
	#monitoring = true
	input_pickable = true


func _on_mouse_entered() -> void:
	#print("Entro el mouse",self)
	if TorrePosActive:
		#print("entro:",self)
		_on_torre_zone_entered.emit(self)
		ShowArea()
		

func _on_mouse_exited() -> void:
	#print("Se fue el mouse",self)
	if TorrePosActive:
		#print("salio:",self)
		_on_torre_zone_exited.emit(self)
		HighLightArea.hide()

func _on_torre_selected() -> void:
	TorrePosActive = true 

func _on_torre_de_selected() -> void:
	TorrePosActive = false
	HighLightArea.hide()

func ShowArea() -> void:
	HighLightArea.show()

func HideArea() -> void:
	HighLightArea.hide()
