class_name Player extends CharacterBody2D

@onready var hull_integrity: HullIntegrity = $HullIntegrity

@onready var launch_point: Marker2D = $Weapon/LaunchPoint
@onready var weapon: Node2D = $Weapon
@export var speed: int = 400
@onready var submarine_sprite: Sprite2D = $SubmarineSprite

var first_weapon_held: bool = false
signal harpoon_shot
signal weapon_shot
	
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	weapon.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("switch_weapon1"):
		first_weapon_held = true
	
	elif Input.is_action_just_pressed("switch_weapon2"):
		first_weapon_held = false
	
	if Input.is_action_just_pressed("shoot_harpoon"):
		harpoon_shot.emit()
	
	if Input.is_action_pressed("shoot_weapon"):
		weapon_shot.emit()

	#WASD movement
	var input = Input.get_vector("left", "right", "up", "down")
	if input.x == -1:
		submarine_sprite.flip_h = true
	elif input.x == 1:
		submarine_sprite.flip_h = false
		
	velocity = input * speed
	move_and_slide() 
	
