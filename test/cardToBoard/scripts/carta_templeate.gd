extends Node2D

@export var TorreCorrespondiete : PackedScene
@export var TorreParent : Node
@export var ResourcePool : PackedScene

var Torre : Node2D = null
var ManejoPool : Node = null

var IsTorreSelected : bool = false
var IsOnTorreZone : bool = false

const TorreCost : int = 5

signal _on_torre_selected
signal _on_torre_de_selected

func _ready():
	ManejoPool = ResourcePool.instantiate()
	add_child(ManejoPool)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if IsTorreSelected:
			Torre.position = event.position
	if event is InputEventMouseButton and IsTorreSelected:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			_on_torre_de_selected.emit()
			SacarTorre()
		elif event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed and IsOnTorreZone:
			_on_torre_de_selected.emit()
			PlantarTorre()			

func _on_button_pressed() -> void:
	Torre = TorreCorrespondiete.instantiate()
	IsTorreSelected = true
	TorreParent.add_child(Torre)
	_on_torre_selected.emit()


func __on_torre_zone_entered() -> void:
	IsOnTorreZone = true

func __on_torre_zone_exited() -> void:
	IsOnTorreZone = false


func PlantarTorre() -> void:
	if ManejoPool.has_method("SpendRecuerdos"):
		ManejoPool.SpendRecuerdos(TorreCost)
	
	Torre.call("_on_plant")	
	IsOnTorreZone = false
	IsTorreSelected = false

func SacarTorre() -> void:
	IsTorreSelected = false
	TorreParent.remove_child(Torre)
	Torre = null
