class_name CrabChase extends State

var crab: Crab
var speed: int = 150

func enter() -> void:
	self.crab = owner_node as Crab
	var player: Player = crab.enemy_component.player
	
func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	var player: Player = crab.enemy_component.player
	crab.velocity = crab.position.direction_to(player.position) * speed
	crab.rotation = crab.position.direction_to(player.position).angle()
	if get_dist_to_player() > 500:
		crab.enemy_component.state_machine.change_state(CrabIdle)
		
func exit() -> void:
	crab.velocity = Vector2.ZERO

func get_dist_to_player() -> float:
	var player: Player = crab.enemy_component.player
	return crab.global_position.distance_to(player.global_position)

## moves towards the player 
func move() -> void:
	pass
