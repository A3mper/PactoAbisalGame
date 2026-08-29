extends Node

signal recuerdos_changed(nueva_cantidad: int)

@export var MAX_RECUERDOS : int = 20
@export var etiqueta: Label 

var recuerdos_actual : int = MAX_RECUERDOS 

func _ready():
	recuerdos_changed.emit(recuerdos_actual)

		
func RecoverRecuerdos(mana: int) -> void:
	recuerdos_actual += mana
	if recuerdos_actual > MAX_RECUERDOS:
		recuerdos_actual = MAX_RECUERDOS
	recuerdos_changed.emit(recuerdos_actual)
	
func SpendRecuerdos(mana: int) -> void:
	recuerdos_actual -= mana
	if recuerdos_actual < 0:
		recuerdos_actual = 0
	recuerdos_changed.emit(recuerdos_actual)

func _on_recuerdos_changed(nueva_cantidad: int) -> void:
	etiqueta.text = str(nueva_cantidad)
