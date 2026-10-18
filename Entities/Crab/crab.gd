class_name Crab extends CharacterBody2D

@export var enemy_component: EnemyComponent

func initialize(player: Player) -> void:
	enemy_component.initialize(player, CrabIdle)
	enemy_component.state_machine.setup(self)
	enemy_component.state_machine.change_state(enemy_component.initial_state)

func _ready() -> void:
	pass
	
func updates(delta: float) -> void:
	enemy_component.state_machine.update(delta)

func _physics_process(delta: float) -> void:
	enemy_component.state_machine.physics_update(delta)
	move_and_slide()
