extends Node

@export var EnemyScene : PackedScene
@export var SpawnPoint : Path2D

var Enemy : Node2D = null

var RoadFollower : PathFollow2D = null

var IsSpawn : bool = false

func _ready():
	pass
	
func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_1:
			spawnEnemy()

func spawnEnemy():
	RoadFollower = PathFollow2D.new()
	Enemy = EnemyScene.instantiate()
	SpawnPoint.add_child(RoadFollower)
	RoadFollower.add_child(Enemy)
	RoadFollower.v_offset = randf_range(-10,10)
	IsSpawn = true
