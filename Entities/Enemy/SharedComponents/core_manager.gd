class_name CoreManager extends Node

## cores remaining until death
var cores_remaining: float
## maximum stun cores that the enemy has
@export var max_cores: float = 4

signal died
signal core_removed()

func _ready() -> void:
	cores_remaining = max_cores

## decreases the core count of the enemy. calling class handles what this looks like visually
func remove_core() -> void:
	cores_remaining = clampf(cores_remaining - 1, 0, max_cores)
	core_removed.emit()
	if cores_remaining <= 0:
		died.emit()
