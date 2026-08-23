extends StaticBody3D

@export var file_clase_a_implementar : clase_abstracta_A


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(file_clase_a_implementar)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	file_clase_a_implementar.algo()
	
