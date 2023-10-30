extends Sprite2D

@export var maxSpeed : float = 2
@export var mass : float = 2

var velocity = Vector2(0,0)
func _ready():
	pass


func _process(delta):
	var moveDirection = Vector2(0,0)
	
	moveDirection.x += float(Input.is_key_pressed(KEY_D)) - float(Input.is_key_pressed(KEY_A))
	moveDirection.y += float(Input.is_key_pressed(KEY_S)) - float(Input.is_key_pressed(KEY_W))
	moveDirection = moveDirection.normalized()
	
	var targetVelocity = moveDirection * maxSpeed
	var velocityDifferance = targetVelocity - velocity
	
	velocity += velocityDifferance / mass * delta / 0.016
	velocity.limit_length(maxSpeed)
	
	self.scale.x = -abs(self.scale.x) if velocity.x <= 0 else abs(self.scale.x)
	self.position += velocity * delta / 0.016
	pass
