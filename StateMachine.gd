extends Node

class_name StateMachine

var state = null 
var previous_state = null 

@onready var parent = get_parent()

func _state_logic(delta):
	pass

func _get_transition(delta):
	return null
	
func _enter_state(new_state, old_state):
	pass
	
func _exit_state(old_state, new_state):
	pass
	
func set_state(new_state):
	previous_state = state
	state = new_state
	
	if previous_state != null:	
		_exit_state(previous_state, new_state)
	if new_state != null:
		_enter_state(new_state, previous_state)
		
