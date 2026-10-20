class_name GameHUD extends CanvasLayer

@export_range(0.0, 100.0) var hull_percent: float = 100.0
@export_range(0.0, 100.0) var oxygen_percent: float = 100.0
@export var resource_count: int = 0

@onready var hull_label: Label = $Screen/Hull/Margin/Column/HullLabel
@onready var hull_bar: ProgressBar = $Screen/Hull/Margin/Column/HullBar
@onready var resources_label: Label = $Screen/DiveInfo/Margin/Column/ResourcesLabel
@onready var depth_label: Label = $Screen/DiveInfo/Margin/Column/DepthLabel
@onready var oxygen_bar: ProgressBar = $Screen/Oxygen/Margin/Column/OxygenBar
@onready var oxygen_label: Label = $Screen/Oxygen/Margin/Column/OxygenLabel


func _ready() -> void:
	set_hull(hull_percent)
	set_oxygen(oxygen_percent)
	set_resources(resource_count)
	set_depth(0.0)


func set_hull(percent: float) -> void:
	hull_percent = clampf(percent, 0.0, 100.0)
	hull_bar.value = hull_percent
	hull_label.text = "HULL  %d%%" % roundi(hull_percent)


func set_oxygen(percent: float) -> void:
	oxygen_percent = clampf(percent, 0.0, 100.0)
	oxygen_bar.value = oxygen_percent
	oxygen_label.text = "%d%%" % roundi(oxygen_percent)


func set_resources(amount: int) -> void:
	resource_count = maxi(amount, 0)
	resources_label.text = "Resources: %d" % resource_count


func set_depth(meters: float) -> void:
	depth_label.text = "Depth: %d m" % roundi(maxf(meters, 0.0))
