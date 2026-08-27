extends Node

@export var EnemyScene : PackedScene
@export var SpawnPoint : PathFollow2D

var Enemy : Node2D = null

func _ready():
	Enemy = EnemyScene.instantiate()
	SpawnPoint.add_child(Enemy)
	SpawnPoint.v_offset = randf_range(-10,10)

func _process(delta):
	SpawnPoint.progress += 10 * delta
		