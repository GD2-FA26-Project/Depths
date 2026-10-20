class_name EnemyStunned extends State

var enemy: EnemyComponent

func enter() -> void:
	enemy = owner_node.get_node("EnemyComponent")
	assert(enemy)
	get_tree().create_timer(4).timeout.connect(
		func(): enemy.state_machine.change_state(enemy.initial_state)
	)
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
		
func exit() -> void:
	enemy.stun_manager.reset()
	
