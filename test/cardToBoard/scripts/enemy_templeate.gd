extends CharacterBody2D

var IsInArea : bool = false



'''
func _physics_process(delta: float) -> void:
	if IsInArea:
		velocity.x = 5 * 100 * delta
	
	move_and_slide()
'''