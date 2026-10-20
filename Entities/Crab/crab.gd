class_name Crab extends CharacterBody2D

@export var enemy_component: EnemyComponent
@onready var core_markers: Node2D = $CoreMarkers
const CORE = preload("uid://bw0hdhei2k6ha")

func initialize(player: Player) -> void:
	enemy_component.initialize(player, CrabIdle)
	enemy_component.state_machine.setup(self)
	enemy_component.state_machine.change_state(enemy_component.initial_state)

func _ready() -> void:
	create_cores()
	
func updates(delta: float) -> void:
	enemy_component.state_machine.update(delta)

func _physics_process(delta: float) -> void:
	enemy_component.state_machine.physics_update(delta)
	move_and_slide()

func create_cores() -> void:
	for marker in core_markers.get_children():
		var core: Core = CORE.instantiate()
		core.initialize(self)
		marker.add_child(core)
		
