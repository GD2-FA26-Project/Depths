class_name WormChase extends State

var worm: Worm

func enter() -> void:
	self.worm = owner_node as Worm
	assert(worm)
	chase()

func physics_update(delta: float) -> void:
	move()
	if worm.head.global_position.distance_to(worm.target) < 10:
		worm.enemy_component.state_machine.change_state(WormTravel)
	
func chase() -> void:
	worm.target = worm.enemy_component.player.global_position

func move() -> void:
	worm.head.velocity = worm.head.global_position.direction_to(worm.target) * worm.speed
	worm.head.rotation = worm.head.global_position.direction_to(worm.target).angle()
	worm.head.move_and_slide()
