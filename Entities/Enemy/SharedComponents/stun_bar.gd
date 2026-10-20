class_name StunBar extends ProgressBar

@export var stun_manager: StunManager

func _ready() -> void:
	stun_manager.stun_charge_changed.connect(update_stun_bar)
	max_value = stun_manager.stun_capacity
	value = stun_manager.stun_charge

func update_stun_bar(old: float, new: float) -> void:
	value = new

	
