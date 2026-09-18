extends Node2D

@export var BotonCambiaModo : Button
@export var SpriteRad : Sprite2D
@export var SpriteVoid : Sprite2D
@export var SpriteMaskRad : Sprite2D
@export var SpriteMaskVoid : Sprite2D
@onready var animation_player = $%AnimationPlayer
@export var TweenTime : float = 0.5

signal _in_radiance
signal _in_void

var IsRad : bool = true
var transitionTween : Tween

func _ready():
	# Estado inicial visual
	SpriteRad.show()
	SpriteRad.modulate.a = 1.0
	
	SpriteMaskRad.show()
	SpriteMaskRad.modulate.a = 1.0

	SpriteVoid.show()
	SpriteVoid.modulate.a = 0.0

	SpriteMaskVoid.show()
	SpriteMaskVoid.modulate.a = 0.0

	# Avisar a todos los objetos cuál es el mundo inicial
	modo_radiance()


func _on_button_pressed() -> void:
	IsRad = not IsRad   
	
	if IsRad:
		modo_radiance()
	else:
		modo_void()
'''
func CompuertaXOR(A: bool,B : bool) -> bool:
	#magia oscura de la electronica, no tocar
	return (((A) and (not B)) or ((not A) and (B)))
'''

func modo_radiance():
	$"../../Audio/SFX/swipeSFX".play()
	animation_player.play("swipeToRadiant")
	Transicion(SpriteMaskVoid,SpriteMaskRad)
	Transicion(SpriteVoid,SpriteRad)
	_in_radiance.emit()
	#musica de rad
	
	#SpriteRad.show()
	#SpriteVoid.hide()

func modo_void():
	$"../../Audio/SFX/swipeSFX".play()
	animation_player.play("swipeToVoid")
	Transicion(SpriteMaskRad,SpriteMaskVoid)
	Transicion(SpriteRad,SpriteVoid)
	_in_void.emit()
	#musica de void
	#SpriteRad.hide()
	#SpriteVoid.show()

func Transicion(from: Sprite2D, to: Sprite2D) -> void:
	

	# 2. Creamos un Tween nuevo para esta transición
	transitionTween = create_tween()
	
	# 3. Hacemos que la opacidad de ambos cambie EN PARALELO al mismo tiempo
	transitionTween.set_parallel(true)
	transitionTween.set_trans(Tween.TRANS_CUBIC)
	transitionTween.set_ease(Tween.EASE_OUT)

	transitionTween.tween_property(from, "modulate:a", 0.0, TweenTime)
	transitionTween.tween_property(to, "modulate:a", 1.0, TweenTime)
