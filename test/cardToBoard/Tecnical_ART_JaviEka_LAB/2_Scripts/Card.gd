extends Node3D

var mouse_position := Vector3.ZERO
var target_rotation := Vector3.ZERO
var max_rotation := 10.0

func _on_area_3d_mouse_entered() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector3(1.08, 1.08, 1.08), 0.25)


func _on_area_3d_mouse_exited() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_ELASTIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "scale", Vector3.ONE, 0.25)


func _on_area_3d_input_event(camera: Node, event: InputEvent, event_position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event is InputEventMouseMotion:
		mouse_position = event_position
		
		target_rotation.x = -mouse_position.y * max_rotation
		target_rotation.y = mouse_position.x * max_rotation


func _process(delta: float) -> void:
	rotation_degrees.x = lerp(rotation_degrees.x, target_rotation.x, delta * 10.0)
	rotation_degrees.y = lerp(rotation_degrees.y, target_rotation.y, delta * 10.0)
