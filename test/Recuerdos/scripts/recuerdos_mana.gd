class_name RecuerdosMana
extends Node

const MAX_RECUERDOS := 15
var recuerdos_actual := MAX_RECUERDOS

func CheckCountRecuerdos(): 
	return recuerdos_actual
	
func RecoverRecuerdos(mana: int) -> void:
	recuerdos_actual += mana
	if recuerdos_actual > MAX_RECUERDOS:
		recuerdos_actual = MAX_RECUERDOS
	
func SpendRecuerdos(mana: int) -> void:
	recuerdos_actual -= mana
	if recuerdos_actual < 0:
		recuerdos_actual = 0
