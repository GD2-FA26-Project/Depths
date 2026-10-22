class_name Turret extends Node2D

const BULLET = preload("res://Entities/Bullet/projectile.tscn")

var player: Player

@export var aim_error_degrees: float = 18.0

func initialize(player: Player) -> void:
	self.player = player

func _ready() -> void:
	while true:
		shoot()
		await get_tree().create_timer(1).timeout

func shoot() -> void:
	if not is_instance_valid(player):
		return

	var instance = BULLET.instantiate()

	var direction_to_player = global_position.direction_to(
		player.global_position
	)
	var aim_angle = direction_to_player.angle() + PI / 2

	aim_angle += deg_to_rad(
		randf_range(-aim_error_degrees, aim_error_degrees)
	)

	instance.dir = aim_angle
	instance.spawnPos = global_position
	instance.spawnRot = aim_angle

	get_parent().add_child.call_deferred(instance)
