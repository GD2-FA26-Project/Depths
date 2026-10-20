class_name HullBar extends ProgressBar

@export var hull_integrity: HullIntegrity

func _ready() -> void:
	hull_integrity.hull_health_changed.connect(update_hull_bar)
	max_value = hull_integrity.hull_capacity
	value = hull_integrity.hull_capacity

func update_hull_bar(old: float, new: float) -> void:
	value = new
