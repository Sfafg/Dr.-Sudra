extends Node

@onready var movement = $".." as Movement

func _process(delta: float) -> void:
	var move_direction = Input.get_vector("left", "right", "up", "down")
	movement.move(move_direction * movement.max_speed)
