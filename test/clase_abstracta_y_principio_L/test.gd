extends Control

@export var clase_a_implementar : clase_base_A
@export var etiqueta : Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#print(file_clase_a_implementar)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	etiqueta.text = clase_a_implementar.algo()
	
	
