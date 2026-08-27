extends Node

@export var EnemyScene : PackedScene
@export var SpawnPoint : PathFollow2D

var Enemy : Node2D = null

func _ready():
	Enemy = EnemyScene.instantiate()
	SpawnPoint.add_child(Enemy)

func _process(delta):
	SpawnPoint.progress_ratio += 0.1 * delta
		