extends CharacterBody2D

var IsInArea : bool = false

var RoadFollower : PathFollow2D = null

func _ready():
	RoadFollower = get_parent() as PathFollow2D

func _process(delta: float) -> void:
	RoadFollower.progress += 10 * delta
