extends StaticBody2D

signal OnHit(body: Node2D)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	OnHit.connect(_on_enemy_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += 100 * delta


func _on_enemy_hit(body: Node2D) -> void:
	print("matao")
	print(body.global_position)
