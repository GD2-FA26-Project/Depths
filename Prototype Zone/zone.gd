extends Node2D

func _ready() -> void:
	$Room1.set_camera_limits($Player/Camera2D)
