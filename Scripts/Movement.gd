extends Sprite2D

@export var maxSpeed : float = 2
@export var mass : float = 2
@export var stepFrequency : float = 10
@export var stepInfluence : float = 0.4

var velocity = Vector2(0,0)
var stepTimer = 0
func _process(delta):
	var moveDirection = Vector2(0,0)
	
	moveDirection.x += float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A))
	moveDirection.y += float(Input.is_key_pressed(KEY_S)) - float(Input.is_key_pressed(KEY_W))
	if(moveDirection.length() == 0):
		stepTimer = 0
	else:
		moveDirection = moveDirection.normalized()
		
	
	var targetVelocity = moveDirection * maxSpeed * clamp(abs(sin(stepTimer * stepFrequency)) + 1 - stepInfluence,0,1)
	var velocityDifferance = targetVelocity - velocity
	
	velocity += velocityDifferance / mass * delta / 0.016
	velocity.limit_length(maxSpeed)
	
	self.scale.x = -abs(self.scale.x) if velocity.x <= 0 else abs(self.scale.x)
	self.position += velocity * delta / 0.016
	stepTimer += delta
	pass
