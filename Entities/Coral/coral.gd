class_name Coral extends CharacterBody2D

@export var enemy_component: EnemyComponent
var initial_state: Script = CoralDefending
var stun_duration = 4

func _ready() -> void:
	enemy_component.state_machine.setup(self)
	enemy_component.state_machine.change_state(initial_state)
	enemy_component.state_machine.change_state(CoralDefending)

func updates(delta: float) -> void:
	enemy_component.state_machine.update(delta)

func _physics_process(delta: float) -> void:
	enemy_component.state_machine.physics_update(delta)
	
