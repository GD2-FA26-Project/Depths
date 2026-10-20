class_name HullIntegrity extends Node

## the current health
var hull_health: float
## maximum health
@export var hull_capacity: float = 400

signal died
signal hull_health_changed(new: float, old: float)

func _ready() -> void:
	hull_health = hull_capacity

## applies damage and signals health changes and deaths
func apply_damage(amnt: float) -> void:
	var old_health: float = hull_health
	hull_health = clampf(hull_health - amnt, 0, hull_capacity)
	hull_health_changed.emit(old_health, hull_health)
	if hull_health <= 0:
		died.emit()

func reset() -> void:
	hull_health = hull_capacity
	hull_health_changed.emit(0, hull_capacity)
