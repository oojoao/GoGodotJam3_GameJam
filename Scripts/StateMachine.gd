class_name StateMachine
extends Node

onready var current_state : State = get_child(0)
var unit : Unit

func _ready() -> void:
	unit = get_parent()
	for state in get_children():
		state.unit = unit
		state.state_machine = self
	
func transition_to(var state : String) -> void:
	current_state.exit()
	current_state = get_node(state)
	current_state.enter()

func _physics_process(delta):
	current_state.physics_update(delta)

func _process(delta):
	current_state.update(delta)
