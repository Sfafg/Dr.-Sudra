extends CharacterBody2D

enum State{IDLE = 1, ATTACK = 2}
var current_state = State.IDLE
@onready var ray_cast = $RayCast2D
@onready var player = $"../Player"

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	# Jeżeli widzisz gracza to zmień stan na atak.
	ray_cast.target_position = player.position - position
	
	var sees_player = ray_cast.get_collider() == player
	if  sees_player and current_state == State.IDLE:
		current_state = State.ATTACK
	elif !sees_player and current_state == State.ATTACK:
		current_state = State.IDLE
		velocity *= 0.5
		
	match current_state:
		State.IDLE:
			velocity += Vector2(randf_range(-10,10),randf_range(-10,10))
			
		State.ATTACK:
			velocity = Vector2(player.position - position).normalized() * 250
	
	move_and_slide()
