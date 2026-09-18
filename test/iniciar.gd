extends Button
@onready var creditos = $"../Creditos"
@onready var salir = $"../Salir"

func _on_pressed():
	disabled = true
	hide()
	creditos.hide()
	salir.hide()
	pass # Replace with function body.
