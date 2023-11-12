extends CharacterBody2D

enum State{IDLE = 1, ATTACK = 2, FLEE = 3}
var current_state = State.IDLE
var health = Health.new(100, 100, func on_die():queue_free())

@onready var ray_cast = $RayCast2D
@onready var player = $"../Player"
@onready var projectile = "res://Prefabs/Pocisk.tscn"

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
			velocity = Vector2(player.position - position).normalized() * 300
	
	move_and_slide()
	for i in get_slide_collision_count():
		if get_slide_collision(i).get_collider() == player:
			health.deal_damage(1)
			print(health.health)
			break
		
