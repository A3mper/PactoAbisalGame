extends Node

signal recuerdos_changed(nueva_cantidad: int)

@export var MAX_RECUERDOS : int = 20
@export var etiqueta: Label 

var recuerdos_actual : int = MAX_RECUERDOS 

func _ready():
	recuerdos_changed.emit(recuerdos_actual)

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_2:
			RecoverRecuerdos(5)
		
func RecoverRecuerdos(mana: int) -> bool: # si la recuperacion es correcta, se procede
	recuerdos_actual += mana
	if recuerdos_actual > MAX_RECUERDOS:
		recuerdos_actual = MAX_RECUERDOS
		return false
	recuerdos_changed.emit(recuerdos_actual)
	return true
	
func SpendRecuerdos(mana: int) -> bool:
	recuerdos_actual -= mana
	if recuerdos_actual < 0:
		recuerdos_actual = 0
		return false
	recuerdos_changed.emit(recuerdos_actual)
	return true

func _on_recuerdos_changed(nueva_cantidad: int) -> void:
	etiqueta.text = str(nueva_cantidad)
