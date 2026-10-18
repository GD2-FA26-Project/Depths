class_name EnemyComponent extends Node

#required
@export var state_machine: StateMachine
@export var stun_bar: StunBarComponent
var player: Player
var initial_state: Script

func initialize(player: Player, initial_state: Script) -> void:
	self.player = player
	self.initial_state = initial_state

func _ready() -> void:
	assert(state_machine and player)
	if state_machine.get_state(EnemyStunned) and stun_bar:
		stun_bar.stunned.connect(handle_stun)
		
func _physics_process(delta: float) -> void:
	print(stun_bar.stun_charge)

func handle_stun() -> void:
	if state_machine.current_state != state_machine.get_state(EnemyStunned):
		state_machine.change_state(EnemyStunned)
