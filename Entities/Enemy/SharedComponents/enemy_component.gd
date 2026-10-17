class_name EnemyComponent extends Node

#required
@export var state_machine: StateMachine
@export var stun_bar: StunBarComponent
var player: Player

func initialize(player: Player) -> void:
	self.player = player

func _ready() -> void:
	assert(state_machine and player)
	
	if state_machine.get_state(EnemyStunned) and stun_bar:
		stun_bar.stunned.connect(func(): state_machine.change_state(EnemyStunned))
		
func _physics_process(delta: float) -> void:
	pass
