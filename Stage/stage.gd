class_name Stage extends Node2D

@onready var player: Player = $Player
const HARPOON = preload("uid://b8vxs6ki12cks")
const WORM = preload("res://Entities/Worm/worm.tscn")
var harpoon: Harpoon
const CORAL = preload("uid://ca1ab4t72hyfl")

func _ready() -> void:
	spawn_coral()
	spawn_worm()
	player.shot_made.connect(shoot_harpoon)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("retract_harpoon") and harpoon:
		harpoon.curr_state = harpoon.STATE.RETRACTING
	
func shoot_harpoon() -> void:
	harpoon = HARPOON.instantiate()
	harpoon.hit_made.connect(handle_harpoon_collisions)
	harpoon.initialize(player, get_global_mouse_position())
	harpoon.cached_position = player.global_position
	add_child(harpoon)

func handle_harpoon_collisions(object: Object, impact_position: Vector2) -> void:
	if object is Core:
		extract(object)

#func handle_harpoon_return() -> void:
	#pass

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
