extends CharacterBody2D

var stepsArray : Array[String] = []

@export var EnemySprite : Sprite2D
@export var VelocidadEnemigo : float = 75
@export var EnemyHealth : int = 100
@export var RecuerdosXKill : int = 1
@export var MaxHealthIncrement : float = 25
@export var MaxHealthDecrement : float = 20
@export var MaxSpeedIncrement : float = 33
@export var MaxSpeedDecrement : float = 25


var velCurrEnemigo : float = 0 
var isWalking = true
var IsInArea : bool = false

var RoadFollower : PathFollow2D = null

signal enemy_killed(recuerdo: int)

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
		enemy_killed.emit(RecuerdosXKill)
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
	isWalking = true
	velCurrEnemigo = VelocidadEnemigo
	
func pasos() -> void:
	while has_health() and isWalking:
		var indWait : float = randf_range(1.200,1.100)
		var indSteps : int = randi() % stepsArray.size()
		get_node(stepsArray[indSteps]).volume_db = -30
		get_node(stepsArray[indSteps]).play()
		await get_tree().create_timer(indWait).timeout
			
func detenerse() -> void:
	isWalking = false
	velCurrEnemigo = 0

func ocultarse() -> void:
	hide()

func mostrarse() -> void:
	show()


func ShowDamage()->void:
	
	var tween = create_tween()
	
	# Cambia el color a rojo brillante en 0.1 segundos
	tween.tween_property(EnemySprite, "self_modulate", Color.BROWN, 0.1)
	
	# Vuelve al color original (blanco/normal) en 0.15 segundos
	tween.tween_property(EnemySprite, "self_modulate", Color.WHITE, 0.15)

func ShowDeath() -> void:
	var tween = create_tween()
	tween.tween_property(EnemySprite, "self_modulate", Color.BROWN, 0.01)
	
func IncreaseHealth(incremento : float)->void:
	if incremento > MaxHealthIncrement: # si supera el maxincremento valido, se va
		incremento = MaxHealthIncrement
	#si por ejemplo incremento es 25 significa que es un incremento del 25% de su salud y escala base
	EnemyHealth += int(incremento)
	scale += Vector2.ONE * (incremento/100)

func DecreaseHealth(decremento : float)->void:
	if decremento > MaxHealthDecrement: # si supera el maxincremento valido, se va
		decremento = MaxHealthDecrement
	#si por ejemplo incremento es 25 significa que es un incremento del 25% de su salud y escala base
	EnemyHealth -= int(decremento)
	scale -= Vector2.ONE * (decremento/100)

func IncreaseSpeed(incremento : float)->void:
	if incremento > MaxSpeedIncrement:
		return
	
	detenerse()
	VelocidadEnemigo *= float(1.0 + (incremento/100))
	rotation_degrees -= incremento
	moverse()

func DecreaseSpeed(decremento: float)->void:
	if decremento > MaxSpeedDecrement:
		return
	
	detenerse()
	VelocidadEnemigo *= float(1.0 - (decremento/100))
	rotation_degrees += decremento
	moverse()
