extends Sprite2D

@export var maxSpeed : float = 2
@export var mass : float = 2
@export var stepFrequency : float = 10
@export_range(0.0,1.0) var stepAnimationInfluence : float = 0.4

var velocity = Vector2(0,0)
var stepAnimationTimer = 0
func _process(delta):
	# Pobieranie wejścia z klawiatury.
	var moveDirection = Vector2(0,0)
	moveDirection.x += float(Input.is_key_pressed(KEY_D) || Input.is_key_pressed(KEY_RIGHT)) - float(Input.is_key_pressed(KEY_A) || Input.is_key_pressed(KEY_LEFT))
	moveDirection.y += float(Input.is_key_pressed(KEY_S) || Input.is_key_pressed(KEY_DOWN)) - float(Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_UP))
	
	# Jeśli gracz nie wysyła zadnego inputu,
	# to zrestartuj animację kroku oraz oraz jej nie używaj.
	var stepAnimation = 1
	if(moveDirection.x == 0 && moveDirection.y == 0):
		stepAnimationTimer = 0
	else:
		# Obliczanie animacji kroku na podstawie funkcji sinus i ograniczenie jej od 1 - stepInfluence do 1.
		stepAnimation = sin(stepAnimationTimer * stepFrequency) * 0.5 + 0.5
		stepAnimation = clamp(stepAnimation + 1 - stepAnimationInfluence, 1 - stepAnimationInfluence, 1)
		stepAnimationTimer += delta
		moveDirection = moveDirection.normalized()
	
	# Obliczanie prędkości, którą ma osiągnąć objekt.
	var targetVelocity = moveDirection * maxSpeed
	targetVelocity *= stepAnimation
	
	# Siła potrzebna do skierowania postaci w kierunku targetVelocity.
	var steeringForce = targetVelocity - velocity

	# Integracja przyspieszenia.
	velocity += steeringForce / mass * delta * 60
	velocity.limit_length(maxSpeed)
	
	# Spraw by obiekt był skierowany w stronę kierunku ruchu.
	self.scale.x = -abs(self.scale.x) if velocity.x <= 0 else abs(self.scale.x)
	
	# Integracja prędkości.
	self.position += velocity * delta * 60
