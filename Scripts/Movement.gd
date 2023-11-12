extends CharacterBody2D

@export var speed = 20.0
var is_going_right = true

func _physics_process(delta):
	# Pobieranie wejścia z klawiatury.
	var move_direction = Input.get_vector("left", "right", "up", "down")
	
	# Ustawianie prędkości.
	velocity = move_direction.normalized() * speed * 100
	
	move_and_slide()
	
	# Skierowanie obiektu w strone ruchu.
	if velocity.x != 0 and (velocity.x > 0 != is_going_right):
		is_going_right = velocity.x > 0
		scale.x = -abs(scale.x)
			
