extends Node2D

@export var ModoSwaper : Node2D
@export var PosRad : Marker2D
@export var PosVoid : Marker2D
@export var SwapTime : float = 1.0
@export var ScaleFactor : float = 0.5

var RegularScale : Vector2

func ShowSwap(posToSwap : Vector2)->void:
	var tweenScale = create_tween().set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	var tweenPos = create_tween()
	RegularScale = ModoSwaper.scale
	
	tweenScale.tween_property(ModoSwaper,"global_scale",RegularScale * ScaleFactor, SwapTime/2)
	tweenPos.tween_property(ModoSwaper,"global_position",ModoSwaper.global_position + Vector2(0,500),SwapTime/3)
	tweenPos.tween_property(ModoSwaper,"global_position",posToSwap + Vector2(0,500),SwapTime/3)
	tweenScale.tween_property(ModoSwaper,"global_scale",RegularScale, SwapTime/2)
	tweenPos.tween_property(ModoSwaper,"global_position",posToSwap,SwapTime/3)
	
	
	

func _on_modo_manager__in_radiance() -> void:
	ShowSwap(PosRad.global_position)


func _on_modo_manager__in_void() -> void:
	ShowSwap(PosVoid.global_position)
