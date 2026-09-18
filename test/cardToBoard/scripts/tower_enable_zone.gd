extends Area2D

@export var HighLightArea : MeshInstance2D
@export var HighlightTime : float = 1.0

signal _on_torre_zone_entered(zona:Area2D)
signal _on_torre_zone_exited(zona:Area2D)

var TorrePosActive : bool = false
var highlightTween : Tween = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	input_pickable=false	
	#HighLightArea.hide()
	
	#monitoring = true
	#input_pickable = true


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
		#HideArea()

func _on_torre_selected() -> void:
	#print("fdsohgisodfv")
	TorrePosActive = true
	input_pickable = true

func _on_torre_de_selected() -> void:
	TorrePosActive = false
	input_pickable = false
	#HighLightArea.hide()

func ShowArea() -> void:
	highlightTween = create_tween()
	
	highlightTween.tween_property(HighLightArea,"self_modulate",Color.TRANSPARENT,HighlightTime/2)
	highlightTween.tween_property(HighLightArea,"self_modulate",Color.WHITE,HighlightTime/2)
	#HighLightArea.show()
'''
func HideArea() -> void:
	HighLightArea.hide()
'''
