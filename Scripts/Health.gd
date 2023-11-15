class_name Health

signal damaged(currentHealth, previousHealth)
signal healed(currentHealth, previousHealth)
signal died

var max_health = 0
var health = 0

var on_damaged = Callable()
var on_healed = Callable()
var on_die = Callable()

func _init(max_health: int, initial_health = max_health, on_die = Callable(), on_damaged = Callable(), on_healed = Callable()):
	self.max_health = max_health
	self.health = initial_health
	self.on_damaged = on_damaged
	self.on_healed = on_healed
	self.on_die = on_die


func deal_damage(amount: int):
	var health_before = health
	health = max(health - amount, 0)
	
	if health == 0:
		died.emit()
		if on_die != Callable(): 
			on_die.call()
	else:
		damaged.emit(health, health_before)
		if on_damaged != Callable(): 
			on_damaged.call(health, health_before)
		


func heal(amount: int):
	var health_before = health
	health = min(health + amount, max_health)
	healed.emit(health, health_before)
	if on_healed != Callable(): 
		on_healed.call(health, health_before)
