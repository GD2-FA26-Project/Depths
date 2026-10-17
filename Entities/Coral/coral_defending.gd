class_name CoralDefending extends State

var coral: Coral

func enter() -> void:
	self.coral = self.owner_node as Coral
	coral.enemy_component.stun_bar.stun_resistance = 0.0
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
		
func exit() -> void:
	pass
	
