extends Area2D

@export var torreMadreSprite : Sprite2D
@export var MaxHealth : int = 5

var currentHealth : int = 0

signal _on_game_over

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = MaxHealth
	


func ShowDamage()->void:
	var tween = create_tween()
	
	# Cambia el color a rojo brillante en 0.1 segundos
	tween.tween_property(torreMadreSprite, "self_modulate", Color.BROWN, 0.1)
	
	# Vuelve al color original (blanco/normal) en 0.15 segundos
	tween.tween_property(torreMadreSprite, "self_modulate", Color.WHITE, 0.15)

func ShowDeath() -> void:
	var tween = create_tween()

	tween.tween_property(torreMadreSprite, "self_modulate", Color.BROWN, 0.01)


func _on_body_entered(body: Node2D) -> void:
	currentHealth -= 1
	
	
	body.queue_free()

	if currentHealth <= 0 :
		ShowDamage()
		ShowDeath()
		_on_game_over.emit()
	else:	
		ShowDamage()