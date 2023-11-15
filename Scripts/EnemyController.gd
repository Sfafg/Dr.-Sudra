extends Node2D

var health = Health.new(100, 100, func on_die():queue_free())
var state_machine = StateMachine.new({
	"IDLE": func idle(): movement.move(movement.velocity * 0.99 + Vector2(randf_range(-10,10),randf_range(-10,10))),
	"ATTACK": func attack(): movement.move(Vector2(player.position - movement.position).normalized() * 300),
	"FLEE": func flee(): movement.move(Vector2(movement.position - player.position).normalized() * 300),
})

@onready var ray_cast = $"../RayCast2D"
@onready var movement = $".." as Movement
@onready var player = $"../../Player"
	
func _ready() -> void:
	state_machine.transition_delay("IDLE", 2)
	
func _process(delta: float):
	# Czy gracz jest widoczny
	ray_cast.target_position = player.position - movement.position
	var sees_player = ray_cast.get_collider() == player
	
	if coliding_with_player():
		state_machine.transition_delay("FLEE", 0.5)
		
	if sees_player:
		state_machine.transition("ATTACK")
	
	else:
		if state_machine.transition("IDLE"): movement.velocity *= 0.75
		
	state_machine.execute()
		
func coliding_with_player() -> bool:
	for i in movement.get_slide_collision_count():
		if movement.get_slide_collision(i).get_collider() == player:
			return true
	return false
