class_name StunManager extends Node

## the current stun charge 
var stun_charge: float = 0
## maximum stun charge before a stun happens
@export var stun_capacity: float = 400
## 0 = high resistance, 1 = no resistance
@export_range(0.0, 1.0, 0.05) var stun_resistance: float = 1.0
## in seconds
var stun_duration: int = 4

signal stunned
signal stun_charge_changed(old, new)

func _ready() -> void:
	pass

## applies the charge to the stun bar, and reduces the amount based on stun resistance
func apply_charge(amnt: float) -> void:
	var old_charge: float = stun_charge
	var resisted_amnt: float = amnt * stun_resistance 
	stun_charge = clampf(stun_charge + resisted_amnt, 0, stun_capacity)
	stun_charge_changed.emit(old_charge, stun_charge)
	if stun_charge >= stun_capacity:
		stunned.emit()

func reset() -> void:
	stun_charge = 0
	stun_charge_changed.emit(stun_capacity, 0)
