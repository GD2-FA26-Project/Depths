extends Control

@export var camera_shift: float = 420.0
@export var camera_move_duration: float = 0.5

@onready var camera: Camera2D = $Camera2D
@onready var base_menu: VBoxContainer = $Interface/BaseMenu
@onready var dive_preparation: Control = $Interface/DivePreparation

var base_camera_position: Vector2
var moving: bool = false


func _ready() -> void:
	base_camera_position = get_viewport_rect().size / 2.0
	camera.position = base_camera_position
	camera.force_update_scroll()
	dive_preparation.hide()
	# Connect buttons inside the instanced scene here so editor saves keep them working.
	dive_preparation.get_node("WeaponMenu/BackButton").pressed.connect(_on_back_pressed)
	dive_preparation.get_node("WeaponMenu/StartDivingButton").pressed.connect(_on_start_diving_pressed)
	base_menu.get_node("GoDivingButton").grab_focus()


func _on_go_diving_pressed() -> void:
	if moving:
		return
	moving = true
	base_menu.hide()
	await _move_camera(base_camera_position + Vector2(camera_shift, 0))
	dive_preparation.show()
	dive_preparation.get_node("WeaponMenu/Slot1Options").grab_focus()
	moving = false


func _on_back_pressed() -> void:
	if moving:
		return
	moving = true
	dive_preparation.hide()
	await _move_camera(base_camera_position)
	base_menu.show()
	base_menu.get_node("GoDivingButton").grab_focus()
	moving = false


func _move_camera(target: Vector2) -> void:
	var tween: Tween = create_tween()
	tween.tween_property(camera, "position", target, camera_move_duration)
	await tween.finished


func _on_start_diving_pressed() -> void:
	if not moving:
		get_tree().change_scene_to_file("res://Stage/stage.tscn")


func _on_upgrades_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/upgrades/upgrades.tscn")


func _on_creature_log_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/creature_log/creature_log.tscn")
