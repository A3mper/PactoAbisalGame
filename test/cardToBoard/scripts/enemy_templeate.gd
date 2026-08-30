extends CharacterBody2D

@export var EnemySprite : Sprite2D

const ENEMY_DEBUG_HEALTH := 100

@export var VelocidadEnemigo : int = 10

var velCurrEnemigo : int = 0 

var IsInArea : bool = false

var RoadFollower : PathFollow2D = null

@export var EnemyHealth : int = ENEMY_DEBUG_HEALTH

func _ready():
	moverse()
	RoadFollower = get_parent() as PathFollow2D

func _process(delta: float) -> void:
	RoadFollower.progress += velCurrEnemigo * delta
	if not has_health():
		ShowDeath()
		queue_free()

func has_health() -> bool:
	if EnemyHealth <= 0:
		return false
	else:
		return true

func has_been_shot(damage : int):
	ShowDamage()
	if has_health():
		EnemyHealth -= damage

func moverse() -> void:
	velCurrEnemigo = VelocidadEnemigo

func detenerse() -> void:
	velCurrEnemigo = 0

func ShowDamage()->void:
	var tween = create_tween()
	
	# Cambia el color a rojo brillante en 0.1 segundos
	tween.tween_property(EnemySprite, "self_modulate", Color.BROWN, 0.1)
	
	# Vuelve al color original (blanco/normal) en 0.15 segundos
	tween.tween_property(EnemySprite, "self_modulate", Color.WHITE, 0.15)

func ShowDeath() -> void:
	var tween = create_tween()

	tween.tween_property(EnemySprite, "self_modulate", Color.BROWN, 0.01)
