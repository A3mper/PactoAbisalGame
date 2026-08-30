extends Node2D

@export var TorreCorrespondiete : PackedScene
@export var TorreParent : Node
@export var ResourcePool : Node

var Torre : Node2D = null
var ManejoPool : Node = null

var IsTorreSelected : bool = false
var IsOnTorreZone : bool = false
var IsOcupied : bool = false

@export var TorreCost : int = 5
@export var TorreRefund : int = 3

signal _on_torre_selected
signal _on_torre_de_selected

func _ready():
	pass
	

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if IsTorreSelected:
			Torre.position = event.position
	if event is InputEventMouseButton and IsTorreSelected:
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			_on_torre_de_selected.emit()
			SacarTorre()
		elif event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed and IsOnTorreZone and not IsOcupied:
			#pero si el espacio esta ocupado, simplemente seguir buscando lugar
			_on_torre_de_selected.emit()
			PlantarTorre()			

func _on_button_pressed() -> void:
	Torre = TorreCorrespondiete.instantiate()
	if Torre.has_signal("espacio_ocupado"):
		Torre.espacio_ocupado.connect(_is_torre_zone_ocupied)
	if Torre.has_signal("espacio_libre"):
		Torre.espacio_libre.connect(_is_torre_zone_free)
	
	IsTorreSelected = true
	TorreParent.add_child(Torre)
	_on_torre_selected.emit()

func PlantarTorre() -> void:
	if Torre.has_signal("torre_borrada"):
		Torre.torre_borrada.connect(RefundTorre)

	if ResourcePool.has_method("SpendRecuerdos"):
		if ResourcePool.SpendRecuerdos(TorreCost):
			Torre.call("_on_plant")	
			IsOnTorreZone = false
			IsTorreSelected = false
		else:
			SacarTorre()
	

func SacarTorre() -> void:
	IsTorreSelected = false
	if Torre.has_method("DeleteTorre"):
		Torre.DeleteTorre()
	TorreParent.remove_child(Torre)
	Torre = null


func _on_torre_zone_in() -> void:
	IsOnTorreZone = true

func _on_torre_zone_out() -> void:
	IsOnTorreZone = false

func _is_torre_zone_free()->void:
	#print("free")
	IsOcupied = false

func _is_torre_zone_ocupied()->void:
	#print("ocupied")
	IsOcupied = true

func RefundTorre()->void:
	if ResourcePool.has_method("RecoverRecuerdos"):
		if ResourcePool.RecoverRecuerdos(TorreRefund):
			#SacarTorre()
			print("devuelveme los recuerdos")	
		
	#