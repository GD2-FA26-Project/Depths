class_name Stage extends Node2D

@export_range(1.0, 100.0) var pixels_per_meter: float = 10.0


# Sample cell data until the room generator supplies the actual layout.
@export var map_origin: Vector2 = Vector2.ZERO
@export var map_cell_size: Vector2 = Vector2(700.0, 500.0)
@export var map_cells: Array[Vector2i] = [
	Vector2i(0, 0), Vector2i(1, 0), Vector2i(2, 0),
	Vector2i(0, 1), Vector2i(1, 1), Vector2i(2, 1),
	Vector2i(1, 2), Vector2i(2, 2),
]
@export var current_objectives: PackedStringArray = ["Explore the connected cells.", "Return to the surface base."]
@export var collected_items: PackedStringArray = []

@onready var game_menus: GameMenus = $GameMenus
@onready var hud: GameHUD = $HUD
var starting_depth_y: float

@onready var submarine_gun_timer: Timer = $SubmarineGunTimer

@onready var player: Player = $Player
const HARPOON = preload("uid://b8vxs6ki12cks")
const WORM = preload("res://Entities/Worm/worm.tscn")
const CORAL = preload("uid://ca1ab4t72hyfl")
const SUBMARINE_GUN = preload("uid://b6juc4ni4vo53")
var harpoon: Harpoon
var submarine_bullets: Array[SubmarineGun]
const CRAB = preload("uid://c1eadlrqawygm")

func _ready() -> void:
	starting_depth_y = player.global_position.y
	game_menus.map_opened.connect(_update_map_menu)
	game_menus.menu_opened.connect(_update_pause_menu)
	spawn_coral()
	spawn_worm()
	spawn_crab()
	player.harpoon_shot.connect(shoot_harpoon)
	player.weapon_shot.connect(shoot_weapon_projectile)
	
func _process(_delta: float) -> void:
	hud.set_depth(get_depth_meters())
	
func shoot_harpoon() -> void:
	harpoon = HARPOON.instantiate()
	harpoon.hit_made.connect(handle_harpoon_collisions)
	harpoon.initialize(player, get_global_mouse_position())
	harpoon.cached_position = player.global_position
	add_child(harpoon)

func shoot_submarine_gun() -> void:
	var submarine_gun: SubmarineGun = SUBMARINE_GUN.instantiate()
	var velocity = Vector2.RIGHT.rotated(player.weapon.rotation) * 30
	submarine_gun.initialize(player.launch_point.global_position, velocity, player.weapon.rotation)
	submarine_gun.hit_made.connect(handle_submarine_collisions)
	add_child(submarine_gun)

func handle_submarine_collisions(object: Object, impact_position: Vector2) -> void:
	if object is WormSegment:
		object.worm_owner.enemy_component.stun_bar.apply_charge(20)
	elif object is Crab:
		object.enemy_component.stun_bar.apply_charge(20)
	
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
	coral.enemy_component.initialize(player, CoralDefending)
	add_child(coral)

func spawn_crab() -> void:
	var crab: Crab = CRAB.instantiate()
	crab.initialize(player)
	crab.position = Vector2(-195,571)
	add_child(crab)

func shoot_weapon_projectile() -> void:
	if player.first_weapon_held:
		if submarine_gun_timer.is_stopped():
			shoot_submarine_gun()
			submarine_gun_timer.start()
	else:
		pass


func get_depth_meters() -> float:
	return maxf((player.global_position.y - starting_depth_y) / pixels_per_meter, 0.0)


func _update_map_menu() -> void:
	var cell_size := Vector2(maxf(map_cell_size.x, 1.0), maxf(map_cell_size.y, 1.0))
	var grid_position: Vector2 = (player.global_position - map_origin) / cell_size
	var player_cell := Vector2i(floori(grid_position.x), floori(grid_position.y))
	game_menus.update_map(map_cells, player_cell)


func _update_pause_menu() -> void:
	game_menus.update_menu(current_objectives, collected_items, get_depth_meters(), hud.resource_count)
