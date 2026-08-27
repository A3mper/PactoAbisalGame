extends Label

@onready var recuerdos_mana: RecuerdosMana = get_parent()


func _ready() -> void:
	recuerdos_mana.recuerdos_changed.connect(actualizar_label_recuerdos)
	actualizar_label_recuerdos(recuerdos_mana.CheckCountRecuerdos())


func actualizar_label_recuerdos(cantidad: int) -> void:
	text = "Recuerdos: " + str(cantidad)
