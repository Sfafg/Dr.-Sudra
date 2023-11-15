extends Node2D

var health = Health.new(100, 100, func on_die():queue_free())
var state_machine = StateMachine.new({
	"IDLE": func(): body.move(body.velocity * 0.99 + Vector2(randf_range(-10,10),randf_range(-10,10))),
	"ATTACK": func(): body.move(Vector2(player.position - body.position).normalized() * 300),
	"FLEE": func(): body.move(Vector2(body.position - player.position).normalized() * 300),
})

@onready var ray_cast = $"../RayCast2D"
@onready var body = $".." as Movement
@onready var player = $"../../Player"
	
	
func _process(delta: float):
	if state_machine.is_transition_blocked:
		return
		
	# Czy gracz jest widoczny
	ray_cast.target_position = player.position - body.position
	var sees_player = ray_cast.get_collider() == player
	
	# Jeżeli kolidujesz z graczem zacznij uciekać przez jakiś czas.
	if coliding_with_player():
		state_machine.transition("FLEE");
		state_machine.is_transition_blocked = true
		GameManager.execute_delayed(0.5, func():state_machine.is_transition_blocked = false)
	# Jeżeli widzi gracza to przechodzi w stan Ataku.
	if sees_player:
		state_machine.transition("ATTACK")
	# Jeżeli nie widzi gracza to przechodzi w stan Spoczynku.
	else:
		if state_machine.transition("IDLE"): body.velocity *= 0.75
	
	state_machine.execute()
		
func coliding_with_player() -> bool:
	for i in body.get_slide_collision_count():
		if body.get_slide_collision(i).get_collider() == player:
			return true
	return false
