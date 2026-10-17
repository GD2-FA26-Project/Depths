class_name State extends Node

@warning_ignore("unused_signal")
signal finished(state_class: Script)
var owner_node: Node

func setup(owner_node: Node) -> void:
	self.owner_node = owner_node

func enter() -> void:
	pass
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
		
func exit() -> void:
	pass
	
