class_name Stage extends Node2D

@onready var player: Player = $Player
const HARPOON = preload("uid://b8vxs6ki12cks")
const WORM = preload("res://Entities/Worm/worm.tscn")
const CORAL = preload("uid://ca1ab4t72hyfl")
const SUBMARINE_GUN = preload("uid://b6juc4ni4vo53")
var harpoon: Harpoon

func _ready() -> void:
	spawn_coral()
	spawn_worm()
	player.harpoon_shot.connect(shoot_harpoon)
	player.weapon_shot.connect(shoot_weapon_projectile)
	

func _process(delta: float) -> void:
	pass
	
func shoot_harpoon() -> void:
	harpoon = HARPOON.instantiate()
	harpoon.hit_made.connect(handle_harpoon_collisions)
	harpoon.initialize(player, get_global_mouse_position())
	harpoon.cached_position = player.global_position
	add_child(harpoon)

func shoot_submarine_gun() -> void:
	var submarine_gun: SubmarineGun = SUBMARINE_GUN.instantiate()
	var velocity = Vector2.RIGHT.rotated(player.weapon.rotation) * 10
	submarine_gun.initialize(player.launch_point.global_position, velocity, player.weapon.rotation)
	add_child(submarine_gun)
	
func handle_harpoon_collisions(object: Object, impact_position: Vector2) -> void:
	if object is Core:
		extract(object)
	
func extract(object: Core) -> void:
	harpoon.core_collected = object
	object.reparent(harpoon)

func spawn_worm() -> void:
	var worm: Worm = WORM.instantiate()
	worm.initialize(player)
	add_child(worm)

func spawn_coral() -> void:
	var coral: Coral = CORAL.instantiate()
	coral.enemy_component.initialize(player)
	add_child(coral)

func shoot_weapon_projectile() -> void:
	if player.first_weapon_held:
		shoot_submarine_gun()
	else:
		pass
