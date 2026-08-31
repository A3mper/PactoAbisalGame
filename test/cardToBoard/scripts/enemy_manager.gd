extends Node

@export var EnemySceneRad : PackedScene
@export var EnemySceneVoid : PackedScene
@export var SpawnPoint : Path2D


var EnemyToSpawn : Node2D = null

var RoadFollower : PathFollow2D = null

var IsRad : bool = true
var IsSpawn : bool = false

func _ready():
	pass
	
func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_1:
			$"../../Audio/SFX/EnemySpawn2Sfx000".play
			spawnEnemy()



func spawnEnemy():
	RoadFollower = PathFollow2D.new()
	if IsRad:
		EnemyToSpawn  = EnemySceneRad.instantiate()
		EnemyToSpawn.add_to_group("Radiance")
	else:
		EnemyToSpawn = EnemySceneVoid.instantiate()
		EnemyToSpawn.add_to_group("Void")
	SpawnPoint.add_child(RoadFollower)
	RoadFollower.add_child(EnemyToSpawn )
	RoadFollower.v_offset = randf_range(-10,10)
	IsSpawn = true
	if IsRad:
		$"../../Audio/SFX/RadiantInRadiantModeSfx000".play()
	else:
		$"../../Audio/SFX/RadiantInVoidModeSfx000".play()
		pass
		


func _on_modo_manager__in_radiance() -> void:
	IsRad = true
	get_tree().call_group("Radiance","moverse")
	get_tree().call_group("Void","detenerse")

func _on_modo_manager__in_void() -> void:
	IsRad = false
	get_tree().call_group("Radiance","detenerse")
	get_tree().call_group("Void","moverse")
