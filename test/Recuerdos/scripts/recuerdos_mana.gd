class_name RecuerdosMana
extends Node

signal recuerdos_changed(nueva_cantidad: int)

const MAX_RECUERDOS := 20
var recuerdos_actual := MAX_RECUERDOS

func CheckCountRecuerdos() -> int: 
	return recuerdos_actual
	
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
