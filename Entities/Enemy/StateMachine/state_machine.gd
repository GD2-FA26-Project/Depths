class_name StateMachine extends Node

var _states_by_type: Dictionary[Script, State] = {}
var current_state: State 
var owner_node: Node

@warning_ignore("shadowed_variable")
## finds states from the scene tree and adds them to the state machine
func setup(owner_node: Node) -> void:
	self.owner_node = owner_node
	for state in get_children():
		if state is State:
			state.setup(owner_node)
			_states_by_type[state.get_script()] = state
			state.finished.connect(change_state)
		
func _ready() -> void:
	pass
	
func update(delta: float) -> void:
	current_state.update(delta)
	
func physics_update(delta: float) -> void:
	current_state.physics_update(delta)
	
## returns the state or null if not found
func get_state(state_class: Script) -> State:
	return _states_by_type.get(state_class)

## starts next state and exits the previous state
func change_state(state_class: Script) -> void:
	var next_state = _states_by_type.get(state_class)
	
	if next_state == null:
		push_error("State not found: %s" % state_class)
		return
	
	if current_state:
		current_state.exit()

	current_state = next_state
	current_state.enter()
