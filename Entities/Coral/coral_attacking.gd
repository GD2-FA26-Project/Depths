class_name CoralAttacking extends State

var coral: Coral

func enter() -> void:
	self.coral = self.owner_node as Coral
	coral.enemy_component.stun_bar.stun_resistance = 0.25
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
		
func exit() -> void:
	pass

func calculate_firing_positions() -> void:
	pass
