extends Node2D

#@export var NodeARepresentar : Node
@export var NivelFull : Sprite2D
@export var NivelFullMedio : Sprite2D
@export var NivelMedio : Sprite2D
@export var NivelMedioMedio : Sprite2D
@export var NivelBasico : Sprite2D
@export var ColorNivel : Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	NivelBasico.modulate = ColorNivel
	NivelMedioMedio.modulate = ColorNivel
	NivelMedio.modulate = ColorNivel
	NivelFullMedio.modulate = ColorNivel
	NivelFull.modulate = ColorNivel
	
func EstaNivelBasico()->void:
	NivelBasico.show()
	NivelMedioMedio.hide()
	NivelMedio.hide()
	NivelFullMedio.hide()
	NivelFull.hide()

func EstaNivelMedioMedio()->void:
	NivelBasico.hide()
	NivelMedioMedio.show()
	NivelMedio.hide()
	NivelFullMedio.hide()
	NivelFull.hide()
	
func EstaNivelMedio()->void:
	NivelBasico.hide()
	NivelMedioMedio.hide()
	NivelMedio.show()
	NivelFullMedio.hide()
	NivelFull.hide()

func EstaNivelFullMedio()->void:
	NivelBasico.hide()
	NivelMedioMedio.hide()
	NivelMedio.hide()
	NivelFullMedio.show()
	NivelFull.hide()

func EstaNivelFull()->void:
	NivelBasico.hide()
	NivelMedioMedio.hide()
	NivelMedio.hide()
	NivelFullMedio.hide()
	NivelFull.show()
