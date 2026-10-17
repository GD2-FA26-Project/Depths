class_name StunBarComponent extends ProgressBar

## the current stun charge 
var stun_charge: int = 0
## maximum stun charge before a stun happens
@export var stun_capacity: int = 400
## 0 = high resistance, 1 = no resistance
@export_range(0.0, 1.0, 0.05) var stun_resistance: float = 1.0
## in seconds
var stun_duration: int = 4

signal stunned

func _ready() -> void:
	stun_capacity = stun_capacity

## applies the charge to the stun bar, and reduces the amount based on stun resistance
func apply_charge(amnt: float) -> void:
	var charge: float = amnt * stun_resistance 
	stun_charge = clampf(stun_charge + charge, 0, stun_capacity)
	value = stun_charge
	if stun_charge >= stun_capacity:
		stunned.emit()

func reset() -> void:
	stun_charge = 0
	
