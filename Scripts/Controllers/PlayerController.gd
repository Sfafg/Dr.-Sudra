extends Node

@onready var shoot = $"../Shooting" as Shooter
@onready var movement = $".." as Movement
	
func _process(delta: float) -> void:
	# Ustaw kierunek ruchu gracza na input.
	var move_direction = Input.get_vector("left", "right", "up", "down")
	movement.move(move_direction * movement.max_speed)
	
	var global_mouse_pos = get_viewport().get_camera_2d().get_viewport_transform() * get_viewport().get_mouse_position()
	if Input.is_key_pressed(KEY_E):
		shoot.shoot(global_mouse_pos.normalized())
