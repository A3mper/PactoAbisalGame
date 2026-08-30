extends Node2D

@export var BotonCambiaModo : Button
@export var SpriteRad : Sprite2D
@export var SpriteVoid : Sprite2D

signal _in_radiance
signal _in_void

var IsRad : bool = true
var transitionTween : Tween

func _ready():
	# Estado inicial visual
	SpriteRad.show()
	SpriteRad.modulate.a = 1.0
	
	SpriteVoid.show() # Ambos visibles, controlamos la opacidad
	SpriteVoid.modulate.a = 0.0

func _on_button_pressed() -> void:
	IsRad = CompuertaXOR(IsRad,true)    
	
	if IsRad:
		modo_radiance()
	else:
		modo_void()

func CompuertaXOR(A: bool,B : bool) -> bool:
	#magia oscura de la electronica, no tocar
	return (((A) and (not B)) or ((not A) and (B)))

func modo_radiance():
	Transicion(SpriteVoid,SpriteRad)
	_in_radiance.emit()
	#SpriteRad.show()
	#SpriteVoid.hide()

func modo_void():
	Transicion(SpriteRad,SpriteVoid)
	_in_void.emit()
	#SpriteRad.hide()
	#SpriteVoid.show()

func Transicion(from: Sprite2D, to: Sprite2D) -> void:
	# 1. Si hay una transición en curso (ej. spam de clics), la cancelamos
	if transitionTween and transitionTween.is_running():
		transitionTween.kill()

	# 2. Creamos un Tween nuevo para esta transición
	transitionTween = create_tween()
	
	# 3. Hacemos que la opacidad de ambos cambie EN PARALELO al mismo tiempo
	transitionTween.set_parallel(true)
	transitionTween.set_trans(Tween.TRANS_CUBIC)
	transitionTween.set_ease(Tween.EASE_OUT)
	
	transitionTween.tween_property(from, "modulate:a", 0.0, 0.5)
	transitionTween.tween_property(to, "modulate:a", 1.0, 0.5)
