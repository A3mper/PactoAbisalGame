extends Area2D

@export var TMSFullHealth : Sprite2D
@export var TMSMidHealth : Sprite2D
@export var TMSLowHealth : Sprite2D
@export var MaxHealth : int = 6
#@export var HealthLabel : Label

var currentHealth : int = 0

signal _on_game_over

var thirdHealth : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	currentHealth = MaxHealth
	TMSFullHealth.show()
	TMSMidHealth.hide()
	TMSLowHealth.hide()
	thirdHealth = int(MaxHealth / 3.0)

func ShowDamage(daSprite : Sprite2D)->void:
	var tween = create_tween()
	
	tween.tween_property(daSprite, "self_modulate", Color.BROWN, 0.1)
	tween.tween_property(daSprite, "self_modulate", Color.WHITE, 0.15)

func ShowDeath() -> void:
	var tween = create_tween()

	tween.tween_property(TMSLowHealth , "self_modulate", Color.BROWN, 0.1)


func _on_body_entered(body: Node2D) -> void:
	currentHealth -= 1
	get_node("/root/CardToScene/Audio/SFX/EnemyImpactSfx000").play()
	
	body.queue_free()
	healthMonitor()
	
func healthMonitor()->void:
	
	if currentHealth <= thirdHealth * 3 and currentHealth > thirdHealth * 2:
		ShowDamage(TMSFullHealth)
		TMSFullHealth.show()
		TMSMidHealth.hide()
		TMSLowHealth.hide()
	elif currentHealth <= thirdHealth * 2 and currentHealth > thirdHealth:
		ShowDamage(TMSMidHealth)
		TMSFullHealth.hide()
		TMSMidHealth.show()
		TMSLowHealth.hide()
	elif currentHealth <= thirdHealth and currentHealth > 0:
		ShowDamage(TMSLowHealth)
		TMSFullHealth.hide()
		TMSMidHealth.hide()
		TMSLowHealth.show()
	elif currentHealth <= 0:
		ShowDeath()
		_on_game_over.emit()
