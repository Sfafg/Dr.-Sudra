class_name Health
extends Node

signal damaged(currentHealth, previousHealth)
signal healed(currentHealth, previousHealth)
signal died

@export var max_health = 100
@export var _health = 100
@export var die_on_no_health = true

func deal_damage(amount: int):
	var health_before = _health
	_health = max(_health - amount, 0)
	
	if die_on_no_health && _health == 0:
		died.emit()
	else:
		damaged.emit(_health, health_before)


func heal(amount: int):
	var health_before = _health
	_health = min(_health + amount, max_health)
	healed.emit(_health, health_before)
