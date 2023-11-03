extends Sprite2D

@export var max_speed = 7.0
@export var mass = 2.0
var velocity = Vector2(0,0)

func _process(delta):
	# Pobieranie wejścia z klawiatury.
	var move_direction = Input.get_vector("left", "right", "up", "down")
	
	# Obliczanie prędkości, którą ma osiągnąć objekt.
	var target_velocity = move_direction.normalized() * max_speed
	
	# Siła potrzebna do skierowania postaci w kierunku target_velocity.
	var steering_force = target_velocity - velocity

	# Integracja przyspieszenia.
	velocity += steering_force / mass * delta * 60
	velocity.limit_length(max_speed)
	
	# Spraw by obiekt był skierowany w stronę kierunku ruchu.
	self.scale.x = -abs(self.scale.x) if velocity.x <= 0 else abs(self.scale.x)
	
	# Integracja prędkości.
	self.position += velocity * delta * 60
