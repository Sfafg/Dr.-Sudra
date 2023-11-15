class_name StateMachine
extends Node
	
var states: Dictionary
var current_state:String
var is_timer_blocked = false

func _init(states:Dictionary, initial_state = ""):
	self.states = states
	if initial_state == "":
		initial_state = states.keys()[0]
	self.current_state = initial_state 

	
func execute():
	states[current_state].call()


func transition(state:String) -> bool:
	if is_timer_blocked or current_state == state:
		return false
	
	current_state = state
	
	return true

func transition_delay(state:String, time_sec:float):
	if is_timer_blocked or current_state == state:
		return false
	
	var f = func wait(): 
		current_state = state
		is_timer_blocked = true
		await GlobalNode.get_tree().create_timer(time_sec).timeout
		is_timer_blocked = false
	f.call()
	
	return true
