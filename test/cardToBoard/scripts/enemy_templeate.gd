extends Node2D

var IsInArea : bool = false

var RoadFollower : PathFollow2D = null

var EnemyHealth : int = 0

func _ready():
	EnemyHealth = 100
	RoadFollower = get_parent() as PathFollow2D

func _process(delta: float) -> void:
	has_health()
	RoadFollower.progress += 10 * delta

func has_health():
	if EnemyHealth == 0:
		queue_free()