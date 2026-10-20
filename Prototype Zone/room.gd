extends Node2D

const ROOM_WIDTH = 3840
const ROOM_HEIGHT = 2160

func _ready() -> void:
	get_node("RoomTrigger").body_entered.connect(_on_body_entered)

func set_camera_limits(camera: Camera2D) -> void:
	camera.limit_left = int(global_position.x)
	camera.limit_top = int(global_position.y)
	camera.limit_right = int(global_position.x + ROOM_WIDTH)
	camera.limit_bottom = int(global_position.y + ROOM_HEIGHT)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var camera: Camera2D = body.get_node("Camera2D")
		set_camera_limits(camera)
