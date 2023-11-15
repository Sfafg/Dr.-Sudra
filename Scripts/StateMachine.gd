class_name StateMachine
extends Node
## Generic State Machine
## 
## Takes in a set of states [String, Callable]
## Allows easy and generic state changes.

var states: Dictionary
var current_state:String
var is_transition_blocked = false

func _init(states:Dictionary, initial_state = ""):
	self.states = states
	if initial_state == "":
		initial_state = states.keys()[0]
	self.current_state = initial_state 

	
func execute():
	# Uruchamia funkcje aktualnego stanu.
	states[current_state].call()


func transition(state:String) -> bool:
	# Jeżeli jest w trakcie zmiany stanu lub jest już w tym stanie to wyjć z funkcji. 
	if is_transition_blocked or current_state == state:
		return false
	
	current_state = state
	return true
