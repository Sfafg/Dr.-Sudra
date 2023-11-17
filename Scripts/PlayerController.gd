extends Node

@onready var shoot = $".." as Shooting
@onready var movement = $".." as Movement

func _process(delta: float) -> void:
	# Ustaw kierunek ruchu gracza na input.
	var move_direction = Input.get_vector("left", "right", "up", "down")
	movement.move(move_direction * movement.max_speed)
	if Input.is_key_pressed(KEY_E):
		shoot.shoot()
