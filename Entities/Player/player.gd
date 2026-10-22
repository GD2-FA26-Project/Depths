class_name Player extends CharacterBody2D

@onready var hull_integrity: HullIntegrity = $HullIntegrity

@onready var launch_point: Marker2D = $Weapon/LaunchPoint
@onready var weapon: Node2D = $Weapon
@onready var submarine_sprite: Sprite2D = $SubmarineSprite
@onready var visual_pivot: Node2D = $VisualPivot

# Movement settings
@export var speed: float = 400.0
@export var acceleration: float = 600.0
@export var deceleration: float = 300.0

var first_weapon_held: bool = false

signal harpoon_shot
signal weapon_shot


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	# Aim weapon toward mouse
	weapon.look_at(get_global_mouse_position())

	# Switch weapons
	if Input.is_action_just_pressed("switch_weapon1"):
		first_weapon_held = true
	elif Input.is_action_just_pressed("switch_weapon2"):
		first_weapon_held = false

	# Shoot harpoon
	if Input.is_action_just_pressed("shoot_harpoon"):
		harpoon_shot.emit()

	# Shoot weapon
	if Input.is_action_pressed("shoot_weapon"):
		weapon_shot.emit()


func _physics_process(delta: float) -> void:
	# Get WASD input
	var input_direction: Vector2 = Input.get_vector(
		"left", "right", "up", "down"
	)

	# Flip submarine based on horizontal velocity
	if velocity.x < -0.1:
		visual_pivot.scale.x = -1.0
	elif velocity.x > 0.1:
		visual_pivot.scale.x = 1.0

	# Calculate desired velocity
	var target_velocity: Vector2 = input_direction * speed

	# Apply acceleration or deceleration
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(
			target_velocity,
			acceleration * delta
		)
	else:
		velocity = velocity.move_toward(
			Vector2.ZERO,
			deceleration * delta
		)

	# Move submarine
	move_and_slide()
	
