class pool_object:

	const POOL_MANAGER := preload("uid://bxmetuy81h1el") #include "pool_manager.h"
	
	var IsActive : bool = false

	var ID : int

	func _init() -> void:
		ID = randi_range(1000,9999)
		POOL_MANAGER._AgregarAPool(self)


	func ObjectToScene():
		pass
	
