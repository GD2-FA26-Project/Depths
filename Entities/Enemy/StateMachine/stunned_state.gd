class_name EnemyStunned extends State

var enemy: EnemyComponent

func enter() -> void:
	enemy = self.owner_node as EnemyComponent
	#get_tree().create_timer(enemy.stun_duration_sec).timeout.connect(
		#func(): enemy.state_machine.change_state()
	#)
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
		
func exit() -> void:
	pass
	
