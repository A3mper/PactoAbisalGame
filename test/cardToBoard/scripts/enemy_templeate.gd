extends CharacterBody2D

const ENEMY_DEBUG_HEALTH := 100

var IsInArea : bool = false

var RoadFollower : PathFollow2D = null

var EnemyHealth : int = ENEMY_DEBUG_HEALTH

func _ready():
	
	RoadFollower = get_parent() as PathFollow2D

func _process(delta: float) -> void:
	RoadFollower.progress += 10 * delta
	if not has_health():
		queue_free()

func has_health() -> bool:
	if EnemyHealth <= 0:
		return false
	else:
		return true

func has_been_shot(damage : int):
	if has_health():
		EnemyHealth -= damage