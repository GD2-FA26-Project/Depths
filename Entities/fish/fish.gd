extends Sprite2D

@export var speed: float = 200.0
@export var size: float = 200.0
@export var radius: float = 100.0

var start_position: Vector2
var angle: float = 0.0
var corner: int = 0
var movement_type: int

var corners: Array[Vector2] = []

func _ready() -> void:
	start_position = global_position

	movement_type = randi_range(0, 2)

	if movement_type == 0:
		corners = [
			start_position,
			start_position + Vector2(size, 0),
			start_position + Vector2(size, size),
			start_position + Vector2(0, size)
		]

	elif movement_type == 1:
		angle = 0.0

	else:
		corners = [
			start_position,
			start_position + Vector2(size, 0),
			start_position + Vector2(size / 2.0, -size)
		]

func _process(delta: float) -> void:
	if movement_type == 0:
		move_polygon(delta, 4)

	elif movement_type == 1:
		move_circle(delta)

	else:
		move_polygon(delta, 3)

func move_circle(delta: float) -> void:
	angle += 2.0 * delta

	global_position = start_position + Vector2(
		cos(angle) * radius,
		sin(angle) * radius
	)

func move_polygon(delta: float, corner_count: int) -> void:
	var target = corners[(corner + 1) % corner_count]

	global_position = global_position.move_toward(
		target, speed * delta
	)

	if global_position.distance_to(target) < speed * delta + 0.1:
		global_position = target
		corner = (corner + 1) % corner_count
