class_name CrabIdle extends State

var crab: Crab

func enter() -> void:
	self.crab = owner_node as Crab
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	if get_dist_to_player() < 500:
		crab.enemy_component.state_machine.change_state(CrabChase)
		
func exit() -> void:
	pass
	
func get_dist_to_player() -> float:
	var player: Player = crab.enemy_component.player
	return crab.global_position.distance_to(player.global_position)

#func pick_dir() -> Vector2:
	#pass

func move() -> void:
	pass
