extends CharacterBody2D

@export var maxSpeed : float = 2
@export var mass : float = 2
@export var stepFrequency : float = 10
@export_range(0.0,1.0) var stepAnimationInfluence : float = 0.4


var stepAnimationTimer = 0
@export var max_speed = 7.0


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
	move_and_slide()
