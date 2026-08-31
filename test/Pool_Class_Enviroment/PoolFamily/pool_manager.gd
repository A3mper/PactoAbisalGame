'''
El PoolManager se tiene que quedar de administrar los pool objects que vengan 
y asegurarse que la cantidad de items en memoria no exceda cierto limite

Es en esencia un array de objetos que se agregan al pool y luego se habilitan y deshabilitan segun haga 

''' 
class pool_manager:

	const _MAX_ITEMS_LIMIT := 1000

	var _cantDeItems := 0
	var _PoolOfItems = []

	func AddToPool(PoolItem) -> void:
		if PoolItem != null:
			if _NewItemInLimit():
				_PoolOfItems.append(PoolItem)
			
	func Checker():
		pass

	func SearchPool(PoolItem):
		if PoolItem != null:
			return _PoolOfItems.find(PoolItem)


	func _NewItemInLimit() -> bool:
		if _cantDeItems < _MAX_ITEMS_LIMIT:
			_cantDeItems += 1
			return true
		else:
			return false

#el equivalente a crear funciones publicas para 

static var z_MPool := pool_manager.new()

static func _AgregarAPool(Item) -> void:
	z_MPool.AddToPool(Item)
