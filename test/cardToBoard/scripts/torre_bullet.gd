extends Node2D

@export var pngbala : Sprite2D = null
@export var balaDur : Timer =null
@export var balaSpeed : int = 2

var transitionTween : Tween

func _ready():
	balaDur.timeout.connect(_on_bullet_duration_timeout)

	Fired(pngbala)

func _process(_delta):
	position.x += balaSpeed


func Fired(from: Sprite2D) -> void:
	transitionTween=create_tween()

	transitionTween.tween_property(from, "modulate",Color.TRANSPARENT, balaDur.wait_time)

func _on_bullet_duration_timeout() -> void:
	queue_free()
