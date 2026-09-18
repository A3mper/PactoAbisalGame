extends Node

@export var MAX_RECUERDOS : int = 20
@export var RECUERDOS_Label :  Label

signal _on_recuerdo_1_quinto
signal _on_recuerdo_2_quinto
signal _on_recuerdo_3_quinto
signal _on_recuerdo_4_quinto
signal _on_recuerdo_entero

var recuerdos_actual : int = MAX_RECUERDOS 
var quintaRecuerdo : int = 0


func _ready():
	cambiaRecursos(recuerdos_actual)
	RECUERDOS_Label.text = str(recuerdos_actual)
	quintaRecuerdo = int(MAX_RECUERDOS/5)

func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_2:
			RecoverRecuerdos(5)
	
func RecoverRecuerdos(mana: int) -> bool: # si la recuperacion es correcta, se procede
	recuerdos_actual += mana
	if recuerdos_actual >= MAX_RECUERDOS:
		recuerdos_actual = MAX_RECUERDOS
		return false
	RECUERDOS_Label.text = str(recuerdos_actual)
	cambiaRecursos(recuerdos_actual)
	return true
	
func SpendRecuerdos(mana: int) -> bool:
	recuerdos_actual -= mana
	if recuerdos_actual < 0:
		recuerdos_actual = 0
		return false
	RECUERDOS_Label.text = str(recuerdos_actual)
	cambiaRecursos(recuerdos_actual)
	return true

func cambiaRecursos(nueva_cantidad: int) -> void:
	if nueva_cantidad <= quintaRecuerdo:
		_on_recuerdo_1_quinto.emit()
	elif nueva_cantidad > quintaRecuerdo and nueva_cantidad <= quintaRecuerdo * 2:
		_on_recuerdo_2_quinto.emit()
	elif nueva_cantidad > quintaRecuerdo * 2 and nueva_cantidad <= quintaRecuerdo * 3:
		_on_recuerdo_3_quinto.emit()
	elif nueva_cantidad > quintaRecuerdo * 3 and nueva_cantidad <= quintaRecuerdo * 4:
		_on_recuerdo_4_quinto.emit()
	else:
		_on_recuerdo_entero.emit()
