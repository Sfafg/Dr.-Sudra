class_name Movement
extends CharacterBody2D

@export var max_speed = 600.0
@export var steering = 30.0

var _move_direction:Vector2

@onready var sprite_2d: Sprite2D = $Sprite2D

func move(direction:Vector2):
	_move_direction = direction.limit_length(max_speed)
	
func _physics_process(delta):
	# Zmień prędkość obiektu tak aby była podobna do kierunku ruchu.
	var steering_force = (_move_direction - velocity).limit_length(steering)
	velocity += steering_force

	move_and_slide()
	
	# Skierowanie obiektu w strone ruchu.
	if velocity.x != 0:
		sprite_2d.flip_h = velocity.x < 0
