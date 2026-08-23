extends Sprite2D

@export var Obj_disparar : PackedScene
@export var SalidaObj : Marker2D

var AnguloRot : float
var PuntoCentral : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PuntoCentral = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	rotation = AnguloRot


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		#rotar el sprite en base a donde este el mouse
		var lenghtY = event.position.y - PuntoCentral.y
		var lenghtX = event.position.x - PuntoCentral.x
		#print("x +",lenghtX,"| y +",lenghtY)
		AnguloRot = atan2(lenghtY,lenghtX) + deg_to_rad(90)
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			shoot()
		
		
func shoot() -> void:
	
	var proyectil : RigidBody2D= Obj_disparar.instantiate()

	proyectil.global_transform = SalidaObj.global_transform
	proyectil.apply_central_impulse(Vector2.UP * 1000)
	get_tree().current_scene.add_sibling(proyectil)
	pass
