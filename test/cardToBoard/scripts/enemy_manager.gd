extends Node

@export var EnemySceneRad : PackedScene
@export var EnemySceneVoid : PackedScene
@export var SpawnPoints : Array[Path2D]
@export var TimeGameStart : Timer
@export var TimeToSpawn : Timer
@export var TimeToEvaluate : Timer
@export var ResourcePool : Node
@export var MaxTTSFactor : int = 2 #multimplicador que indica que tan grande puede TTS ser en comparasion a si misma
@export var MinTTSFactor : int = 1 #multimplicador que indica que tan chica puede TTS ser en comparasion a si misma
@export var RiskLevelAmount : int = 10
@export var TorreRiskCount : int = 10 #cuantas torres son suficientes torres para los enemigos?
@export var LevelInicial : DEBUG_LEVEL
@export var DebugLabel1: Label = null
@export var DebugLabel2: Label = null

signal _on_risk_top
signal _on_risk_coherente
signal _on_risk_mediocre
signal _on_risk_malhumorado
signal _on_risk_noob

enum RISK_SPEED {SLOW = -1, NEUTRAL, FAST}
enum RISK_HEALTH {WEAKEST = -2, WEAK, STOCK,STRONG,STRONGEST}
enum DEBUG_LEVEL {TOP = -2,COHERENTE,MEDIOCRE,MALHUMORADO,NOOB}

var EnemyToSpawn : Node2D = null

var RoadFollower : PathFollow2D = null

var IsRad : bool = true
var IsEvaluationEnable : bool = false

var MaxTimeToSpawn : float = 0.0
var MinTimeToSpawn : float = 0.0

var EnemiesSpawned : int = 0
var EnemyCount : int = 0
var riskLevel : int = 0
var countEnemyEvaluation : int = 0
var speedLevel : int = RISK_SPEED.NEUTRAL
var healthLevel : int = RISK_HEALTH.STOCK
var torresOnAction : int = 0
var playerLevel : int = DEBUG_LEVEL.MEDIOCRE

func _ready():
	MinTimeToSpawn = TimeToSpawn.wait_time / MinTTSFactor
	MaxTimeToSpawn = TimeToSpawn.wait_time * MaxTTSFactor
	print(MinTimeToSpawn,"-",MaxTimeToSpawn)
	
	DebugLabel1.text = str(riskLevel)
	DebugLabel2.text = str(torresOnAction)	
	TimeGameStart.start()
'''	
func _input(event):
	if event is InputEventKey:
		if event.is_pressed() and event.keycode == KEY_1:
			
			spawnEnemy()
'''
func spawnEnemy():
	#EnemyCountLabel.text = "pto"
	RoadFollower = PathFollow2D.new()
	
	
	#EnemyToSpawn.call("IncreaseHealth",25)
	var randomizadorBananero :int = randi_range(0,3)
	if randomizadorBananero % 2 == 0:
		SpawnRadEnemy()
		#EnemyToSpawn.call("DecreaseSpeed",10)
	else:
		SpawnVoidEnemy()
	
	if EnemyToSpawn.has_signal("enemy_killed"):
		EnemyToSpawn.enemy_killed.connect(enemyToRecuerdo)
		
	randomizadorBananero = randi_range(0,SpawnPoints.size())
	SpawnPoints[randomizadorBananero-1].add_child(RoadFollower)
	
	RoadFollower.add_child(EnemyToSpawn)
	RoadFollower.v_offset = randf_range(-10,10)
	
	match speedLevel:
		RISK_SPEED.SLOW:
			EnemyToSpawn.call("DecreaseSpeed",abs(riskLevel) * 2)
		RISK_SPEED.NEUTRAL:
			pass
		RISK_SPEED.FAST:
			EnemyToSpawn.call("IncreaseSpeed",abs(riskLevel) * 2)
	
	match healthLevel:
		RISK_HEALTH.WEAKEST:
			#aumentar x cantidad de puntos de salud
			EnemyToSpawn.call("DecreaseHealth",abs(riskLevel) * 2)
		RISK_HEALTH.WEAK:
			EnemyToSpawn.call("DecreaseHealth",abs(riskLevel))
		RISK_HEALTH.STOCK:
			pass
		RISK_HEALTH.STRONG:
			EnemyToSpawn.call("IncreaseHealth",abs(riskLevel))
		RISK_HEALTH.STRONGEST:
			EnemyToSpawn.call("IncreaseHealth",abs(riskLevel) * 2)
		
	
	EnemyCount += 1
	#EnemyCountLabel.text = str(EnemyCount)
	#EnemyCountLabel.text = str(countEnemyEvaluation)
	

func _on_modo_manager__in_radiance() -> void:
	IsRad = true
	get_tree().call_group("Radiance","mostrarse")
	get_tree().call_group("Void","ocultarse")

func _on_modo_manager__in_void() -> void:
	IsRad = false
	get_tree().call_group("Radiance","ocultarse")
	get_tree().call_group("Void","mostrarse")

func SpawnRadEnemy():
	EnemyToSpawn  = EnemySceneRad.instantiate()
	$"../../Audio/SFX/RadiantInRadiantModeSfx000".play()
	if IsRad:
		EnemyToSpawn.call("mostrarse")
	else:	
		EnemyToSpawn.call("ocultarse")

func SpawnVoidEnemy():
	EnemyToSpawn = EnemySceneVoid.instantiate()
	$"../../Audio/SFX/RadiantInVoidModeSfx000".play()
	if not IsRad:
		EnemyToSpawn.call("mostrarse")
	else:
		EnemyToSpawn.call("ocultarse")
		
func enemyToRecuerdo(recuerdoRecuperado: int)->void:
	EnemyCount -= 1
	#EnemyCountLabel.text = str(EnemyCount)
	if ResourcePool.has_method("RecoverRecuerdos"):
		if ResourcePool.RecoverRecuerdos(recuerdoRecuperado):
			pass
			
func EnableSpawnEnemies()->void:
	TimeToSpawn.start()
	TimeToEvaluate.start()

	
func riskEvaluation() -> void:
	var cuartoDeECE = int(EnemiesSpawned / 4.0)
	
	#enemy count evaluation and scoring
	if EnemyCount <= cuartoDeECE :
		riskLevel += RiskLevelAmount * 2 # TOP RISK
		#decreasTTS(0.1)
	elif EnemyCount > cuartoDeECE and EnemyCount <= cuartoDeECE  * 2: 
		riskLevel += RiskLevelAmount # COHERENTE RISK
		#decreasTTS(0.05)
	elif EnemyCount > cuartoDeECE * 2 and EnemyCount <= cuartoDeECE  * 3: 
		riskLevel -= RiskLevelAmount # MALHUMORADO RISK
		#increaseTTS(0.05)
	else: 
		riskLevel -= RiskLevelAmount * 2 #NOOB RISK
		#increaseTTS(0.1)
	
	EnemiesSpawned = 0
	EnemyCount = 0
	
	#torre count evaluation and scoring
	
	if torresOnAction < int( TorreRiskCount / 2.0 ):
		riskLevel -= RiskLevelAmount 
	elif torresOnAction >= int(TorreRiskCount / 2.0) and torresOnAction < TorreRiskCount:
		riskLevel += 0
	else:
		riskLevel += RiskLevelAmount 
		
	
	
	if riskLevel > RiskLevelAmount * 4: # TOP
		playerLevel = DEBUG_LEVEL.TOP
		_on_risk_top.emit()
	elif riskLevel <= RiskLevelAmount * 4 and riskLevel > RiskLevelAmount * 2: #COHERENTE
		playerLevel = DEBUG_LEVEL.COHERENTE
		_on_risk_coherente.emit()
	elif riskLevel <= RiskLevelAmount * 2  and riskLevel > -RiskLevelAmount * 2: #MEDIOCRE
		playerLevel = DEBUG_LEVEL.MEDIOCRE
		_on_risk_mediocre.emit()
	elif riskLevel <= -RiskLevelAmount * 2 and riskLevel > -RiskLevelAmount * 4: #MALHUMORADO
		playerLevel = DEBUG_LEVEL.MALHUMORADO
		_on_risk_malhumorado.emit()
	else: #NOOB
		playerLevel = DEBUG_LEVEL.NOOB
		_on_risk_noob.emit()
		
	DebugLabel1.text = str(riskLevel)
	RiskScoring()
	#EnemyCountLabel.text = str(riskLevel )

func increaseTTS(nuevoTiempo : float)->void:
	print("+",nuevoTiempo)
	if nuevoTiempo >= MaxTimeToSpawn:
		nuevoTiempo = MaxTimeToSpawn - 0.1
	DebugLabel2.text = str(nuevoTiempo)
	TimeToSpawn.stop()
	TimeToSpawn.wait_time = nuevoTiempo 
	TimeToSpawn.start()
	
func decreasTTS(nuevoTiempo : float)->void:
	print("-",nuevoTiempo)
	if nuevoTiempo >= MinTimeToSpawn:
		nuevoTiempo = MinTimeToSpawn - 0.1
	DebugLabel2.text = str(nuevoTiempo)
	TimeToSpawn.stop()
	TimeToSpawn.wait_time = nuevoTiempo
	TimeToSpawn.start()
	
func RiskScoring()->void:
	'''
	 RL |---|---|---|---|
		|	|	|	|	NOOB : TTS mas bajo posible. Enemigos lentos y muy debiles
		|	|	|	MALHUMORADO : TTS Por debajo del medio. Enemigos debiles
		|	|	MEDIOCRE : Inicio del sistema. Todo estandar
		|	COHERENTE : TTS elevado. Enemigos fuertes
		TOP: TTS altisimo, Enemigos muy fuertes y rapidos
	'''
	
		
	match playerLevel:
		DEBUG_LEVEL.TOP:
			healthLevel = RISK_HEALTH.STRONGEST
			speedLevel = RISK_SPEED.FAST
			decreasTTS(MinTimeToSpawn)
		DEBUG_LEVEL.COHERENTE:
			healthLevel = RISK_HEALTH.STRONG
			speedLevel = RISK_SPEED.NEUTRAL
			decreasTTS(MinTimeToSpawn * 2)
		DEBUG_LEVEL.MEDIOCRE:
			healthLevel = RISK_HEALTH.STOCK
			speedLevel = RISK_SPEED.NEUTRAL
		DEBUG_LEVEL.MALHUMORADO:
			healthLevel = RISK_HEALTH.WEAK
			speedLevel = RISK_SPEED.NEUTRAL
			increaseTTS(MaxTimeToSpawn/2)
		DEBUG_LEVEL.NOOB:
			healthLevel = RISK_HEALTH.WEAKEST
			speedLevel = RISK_SPEED.FAST
			increaseTTS(MaxTimeToSpawn)
		

func _on_torre_count_updated(valor: int) -> void:
	torresOnAction = valor


func _on_time_to_evaluate_timeout() -> void:
	riskEvaluation()
