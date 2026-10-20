extends Node2D

func _ready() -> void:
	$Room1.set_camera_limits(get_tree().get_first_node_in_group("player").get_node("Camera2D"))
	#TODO is this working
