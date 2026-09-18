extends ColorRect

#const REFERENCIA_CARTA = preload("uid://cikc3f1bkbmt2")

@export var ZoneManager : Node = null

@export var CartaTorreRad : PackedScene
@export var CartaTorreVoid : PackedScene
@export var CartaTempleate : PackedScene

@export var curvaDeMano : Curve
@export var curvaDeRotacion : Curve

@export var RotMaxDegree : int = 10
@export var Separacion_X : float = 30
@export var Max_Y_Pos : int = -70
@export var Min_Y_Pos : int = 50
@export var FactorEscala : float = 0.25

@export var Ajuste_Segunda_Carta_Y : float = 0.0

@export var Ajuste_Mano_X : float = 0.0

signal torre_agregada
signal torre_destruida

var DaCarta : Node2D = null
var noCAMPTA : Node2D = null

var SizeXCarta : float = 0.0
var SizeYCarta : float = 0.0


var cartas_en_mano : Array[Node2D] = []


func _ready() -> void:
	
	
	
	print("Posición deseada: ", size / 2.0)
	
	if CartaTempleate == null:
		print("ERROR: Falta asignar 'CartaTempleate' en el Inspector.")
		return
		
	DaCarta = CartaTempleate.instantiate()
	add_child(DaCarta)
	SizeXCarta = DaCarta.call("get_size_x")
	SizeYCarta = DaCarta.call("get_size_y")
	DaCarta.queue_free()
	
	
	await get_tree().process_frame
	DaCarta = CartaTorreRad.instantiate()
	if DaCarta.has_signal("torre_instalada"):
		DaCarta.torre_instalada.connect(alAgregarTorre)
	if DaCarta.has_signal("torre_desinstalada"):
		DaCarta.torre_desinstalada.connect(alRemoverTorre)
	DaCarta.scale = Vector2.ONE * FactorEscala
	add_child(DaCarta)
	
	cartas_en_mano.append(DaCarta)
	ZoneManager.call("NewCarta", DaCarta)
	
	await get_tree().process_frame
	ActualizarCartas()
	

	await get_tree().process_frame
	noCAMPTA = CartaTorreVoid.instantiate()
	noCAMPTA.scale = Vector2.ONE * FactorEscala
	if noCAMPTA.has_signal("torre_instalada"):
		noCAMPTA.torre_instalada.connect(alAgregarTorre)
	if noCAMPTA.has_signal("torre_desinstalada"):
		noCAMPTA.torre_desinstalada.connect(alRemoverTorre)
	add_child(noCAMPTA)
	
	cartas_en_mano.append(noCAMPTA)
	ZoneManager.call("NewCarta", noCAMPTA)
	
	await get_tree().process_frame
	ActualizarCartas()


func ActualizarCartas() -> void:
	var total_cartas: int = cartas_en_mano.size()
	if total_cartas == 0: 
		return
	
	var ancho_real_carta : float = SizeXCarta * FactorEscala
	var TamanioCartas : float = ancho_real_carta * total_cartas + Separacion_X * (total_cartas - 1)
	var separacionXFinal := Separacion_X
	
	if TamanioCartas > size.x and total_cartas > 1:
		separacionXFinal = (size.x - ancho_real_carta * total_cartas) / (total_cartas - 1)
		TamanioCartas = size.x
		
	var offset := (size.x - TamanioCartas) / 2
	
	for i in total_cartas:
		var Carta := cartas_en_mano[i]
		
		if not is_instance_valid(Carta):
			continue
			
		var multi_y := 0.0
		var multi_rot := 0.0
		
		if total_cartas > 1:
			var ratio := float(i) / float(total_cartas - 1)
			multi_y = curvaDeMano.sample(ratio)
			multi_rot = curvaDeRotacion.sample(ratio)
		
		
		var XFinal : float = offset + ancho_real_carta * i + separacionXFinal * i + Ajuste_Mano_X
		var YFinal : float = Min_Y_Pos + Max_Y_Pos * multi_y
		
		
		if i == 1:
			YFinal += Ajuste_Segunda_Carta_Y
		
		Carta.position = Vector2(XFinal, YFinal)
		Carta.rotation_degrees = RotMaxDegree * multi_rot
		
func alAgregarTorre()->void:
	torre_agregada.emit()
		
func alRemoverTorre()->void:
	torre_destruida.emit()
