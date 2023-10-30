extends Sprite2D

@export var maxSpeed : float = 2
@export var mass : float = 2
@export var stepFrequency : float = 10
@export_range(0.0,1.0) var stepAnimationInfluence : float = 0.4

var velocity = Vector2(0,0)
var stepAnimationTimer = 0
func _process(delta):
	
	# Get Keyboard Input.
	var moveDirection = Vector2(0,0)
	moveDirection.x += float(Input.is_key_pressed(KEY_D) || Input.is_key_pressed(KEY_RIGHT)) - float(Input.is_key_pressed(KEY_A) || Input.is_key_pressed(KEY_LEFT))
	moveDirection.y += float(Input.is_key_pressed(KEY_S) || Input.is_key_pressed(KEY_DOWN)) - float(Input.is_key_pressed(KEY_W) || Input.is_key_pressed(KEY_UP))
	
	# If not moving restart step animation.
	if(moveDirection.length() == 0):
		stepAnimationTimer = 0
	else:
		moveDirection = moveDirection.normalized()
	
	# Calculate step animation based on sin function and clamp it between 1 - stepInfluence and 1
	var stepAnimation = sin(stepAnimationTimer * stepFrequency) * 0.5 + 0.5
	stepAnimation = clamp(stepAnimation + 1 - stepAnimationInfluence, 1 - stepAnimationInfluence, 1)
	stepAnimationTimer += delta
	
	# Calculate velocity that we want the sprite to move at.
	var targetVelocity = moveDirection * maxSpeed
	targetVelocity *= stepAnimation
	
	# Force to steer toward target velocity.
	var steeringForce = targetVelocity - velocity

	# Integrate acceleration.
	velocity += steeringForce / mass * delta * 60
	velocity.limit_length(maxSpeed)
	
	# Make the character face where it is going.
	self.scale.x = -abs(self.scale.x) if velocity.x <= 0 else abs(self.scale.x)
	
	# Integrate velocity.
	self.position += velocity * delta * 60
	
	pass
