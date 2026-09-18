extends Node2D

@export var TorreCorrespondiete : PackedScene
@export var CardButton: Button
@export var IsRad : bool = true

# Sprite que tiene el ShaderMaterial
@export var CardSprite: Sprite2D

# Hover
@export var HoverScale: float = 1.05
@export var HoverAnimationTime: float = 0.15
@export var HoverZIndex: int = 100

signal torre_instalada
signal torre_desinstalada

var Torre : Node2D = null
var TorreParent : Node2D = null

var ManejoPool : Node = null
var ResourcePool : Node = null

var IsTorreSelected : bool = false
var IsOnTorreZone : bool = false
var IsOcupied : bool = false

@export var TorreCost : int = 5
@export var TorreRefund : int = 3

signal _on_torre_selected
signal _on_torre_de_selected

# Variables del Hover
var NormalScale : Vector2
var HoverScaleVector : Vector2
var NormalZIndex : int

var CardShaderMaterial : ShaderMaterial
var HoverTween : Tween


func _ready():
	CardButton.disabled = false
	
	# Guardamos los valores originales
	NormalScale = scale
	HoverScaleVector = NormalScale * HoverScale
	NormalZIndex = z_index
	
	# Comprobamos que exista el Sprite de la carta
	if CardSprite == null:
		print("ERROR CARTA: CardSprite NO está asignado.")
		return
	
	print("Carta: ", name)
	print("CardSprite: ", CardSprite.name)
	print("Material encontrado: ", CardSprite.material)
	
	# Obtener ShaderMaterial
	CardShaderMaterial = CardSprite.material as ShaderMaterial
	
	if CardShaderMaterial == null:
		print("ERROR CARTA: El Sprite2D NO tiene un ShaderMaterial.")
	else:
		print("SHADER ENCONTRADO CORRECTAMENTE")
		CardShaderMaterial.set_shader_parameter("hover_enabled", false)


func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		if IsTorreSelected:
			if TorreParent:
				Torre.position = TorreParent.to_local(get_global_mouse_position())
	
	if event is InputEventMouseButton and IsTorreSelected:
		
		if event.button_index == MouseButton.MOUSE_BUTTON_RIGHT and event.pressed:
			_on_torre_de_selected.emit()
			get_tree().call_group("Cartas", "HabilitarCartas")
			SacarTorre()
		
		elif event.button_index == MouseButton.MOUSE_BUTTON_LEFT and event.pressed and IsOnTorreZone and not IsOcupied:
			_on_torre_de_selected.emit()
			get_tree().call_group("Cartas", "HabilitarCartas")
			PlantarTorre()


func _on_button_pressed() -> void:
	
	Torre = TorreCorrespondiete.instantiate()
	
	if Torre.has_signal("espacio_ocupado"):
		Torre.espacio_ocupado.connect(_is_torre_zone_ocupied)
	
	if Torre.has_signal("espacio_libre"):
		Torre.espacio_libre.connect(_is_torre_zone_free)
	
	get_tree().call_group("Cartas", "DeshabilitarCartas")
	
	IsTorreSelected = true
	IsOnTorreZone = false
	
	if TorreParent:
		TorreParent.add_child(Torre)
	
	_on_torre_selected.emit()


func PlantarTorre() -> void:
	
	if Torre.has_signal("torre_borrada"):
		Torre.torre_borrada.connect(RefundTorre)
	
	if Torre.has_signal("torre_colocada"):
		
		if not IsRad:
			$"../../Audio/SFX/BuildATowerRadFinalSfx000".play()
		else:
			$"../../Audio/SFX/BuildATowerVoid1Sfx000".play()
		
		Torre.torre_colocada.connect(cuentaTorreGlobal)
	
	if ResourcePool:
		if ResourcePool.call("SpendRecuerdos", TorreCost):
			
			Torre.call("_on_plant")
			IsOnTorreZone = false
			IsTorreSelected = false
		
		else:
			SacarTorre()


func SacarTorre() -> void:
	
	IsTorreSelected = false
	
	if Torre.has_method("DeleteTorre"):
		Torre.DeleteTorre()
	
	if TorreParent:
		TorreParent.remove_child(Torre)
	
	Torre = null
	
	$"../../Audio/SFX/BlockPutTowerSfx000".play()


func _on_torre_zone_in() -> void:
	IsOnTorreZone = true


func _on_torre_zone_out() -> void:
	IsOnTorreZone = false


func _is_torre_zone_free() -> void:
	IsOcupied = false


func _is_torre_zone_ocupied() -> void:
	IsOcupied = true


func RefundTorre() -> void:
	
	if ResourcePool:
		if ResourcePool.call("RecoverRecuerdos", TorreRefund):
			torre_desinstalada.emit()


func DeshabilitarCartas() -> void:
	
	if CardButton is Button:
		CardButton.disabled = true


func HabilitarCartas() -> void:
	
	if CardButton is Button:
		CardButton.disabled = false


# ============================================================
# HOVER DE LA CARTA
# ============================================================

func _on_button_mouse_entered() -> void:
	
	print("MOUSE ENTER - ", name)
	
	# Esta carta pasa al frente
	z_index = HoverZIndex
	
	# La carta opuesta pasa detrás
	for carta in get_tree().get_nodes_in_group("Cartas"):
		
		if carta != self and carta is Node2D:
			
			# Si es la carta del modo contrario
			if carta.IsRad != IsRad:
				carta.z_index = NormalZIndex
	
	# Activar Shader
	if CardShaderMaterial:
		print("ACTIVANDO SHADER")
		CardShaderMaterial.set_shader_parameter("hover_enabled", true)
	
	# Sonido
	%PutOnACard3Sfx000.play()
	
	# Detener Tween anterior
	if HoverTween:
		HoverTween.kill()
	
	# Animación de escala
	HoverTween = create_tween()
	HoverTween.set_trans(Tween.TRANS_QUAD)
	HoverTween.set_ease(Tween.EASE_OUT)
	HoverTween.tween_property(
		self,
		"scale",
		HoverScaleVector,
		HoverAnimationTime
	)


func _on_button_mouse_exited() -> void:
	
	print("MOUSE EXIT - ", name)
	
	# Volver al Z Index original
	z_index = NormalZIndex
	
	# Desactivar Shader
	if CardShaderMaterial:
		print("DESACTIVANDO SHADER")
		CardShaderMaterial.set_shader_parameter("hover_enabled", false)
	
	# Detener Tween anterior
	if HoverTween:
		HoverTween.kill()
	
	# Volver a escala normal
	HoverTween = create_tween()
	HoverTween.set_trans(Tween.TRANS_QUAD)
	HoverTween.set_ease(Tween.EASE_OUT)
	HoverTween.tween_property(
		self,
		"scale",
		NormalScale,
		HoverAnimationTime
	)


# ============================================================
# SEÑALES
# ============================================================

func cuentaTorreGlobal() -> void:
	torre_instalada.emit()


# ============================================================
# FUNCIONES EXTERNAS
# ============================================================

func setTorreParent(parent : Node2D) -> void:
	TorreParent = parent


func setResourcePool(RPool : Node) -> void:
	ResourcePool = RPool
