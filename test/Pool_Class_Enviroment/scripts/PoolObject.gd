extends Node
class_name PoolObject

var isActive:= false
var ID:= ""

func EnterToPool() -> void: 
	isActive = false
	pass
	
func ExitFromPool() -> void:
	isActive = true

func getID():
	return ID
