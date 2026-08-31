extends CharacterBody2D

var stepsArray : Array[String] = []

@export var EnemySprite : Sprite2D
var isWalking = true
const ENEMY_DEBUG_HEALTH := 100

@export var VelocidadEnemigo : int = 10

var velCurrEnemigo : int = 0 

var IsInArea : bool = false

var RoadFollower : PathFollow2D = null

@export var EnemyHealth : int = ENEMY_DEBUG_HEALTH

func _ready():
	stepsArray.append("/root/CardToScene/Audio/SFX/Step1Sfx")
	stepsArray.append("/root/CardToScene/Audio/SFX/Step2Sfx")
	stepsArray.append("/root/CardToScene/Audio/SFX/Step3Sfx")
	stepsArray.append("/root/CardToScene/Audio/SFX/Step4Sfx")
	moverse()
	pasos()
	RoadFollower = get_parent() as PathFollow2D



func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("press_r"):
		impact_sound()
		
	RoadFollower.progress += velCurrEnemigo * delta
	if not has_health():
		print("yes")
		ShowDeath()
		queue_free()
		
	
	
func impact_sound():
	get_node("/root/CardToScene/Audio/SFX/EnemyImpactSfx000").play()
	
func has_health() -> bool:
	if EnemyHealth <= 0:
		impact_sound()
		return false
	else:
		return true

func has_been_shot(damage : int):
	ShowDamage()
	if has_health():
		EnemyHealth -= damage
		
func moverse() -> void:
	velCurrEnemigo = VelocidadEnemigo
	
func pasos() -> void:
	while has_health():
		var indWait : int = randf_range(1.2,1.1)
		var indSteps : int = randi() % stepsArray.size()
		get_node(stepsArray[indSteps]).play()
		await get_tree().create_timer(indWait).timeout
			
func detenerse() -> void:
	isWalking = false
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
