class_name WormTravel extends State

var worm: Worm

var player_offset: int = 600
var turning_pts: Array[Marker2D]
var travel_path: Array[Vector2]

func enter() -> void:
	self.worm = owner_node as Worm
	set_turning_pts()
	follow_path()
	assert(worm)

func physics_update(delta: float) -> void:
	move()
	if worm.head.global_position.distance_to(worm.target) < 10:
		travel_path.pop_front()
		if !travel_path.is_empty(): worm.target = travel_path[0]
		else: worm.enemy_component.state_machine.change_state(WormChase)
	
func follow_path() -> void:
	var starting_index: int = randi_range(0, turning_pts.size() - 2)
	var rand_starting_pt: Vector2 = turning_pts[starting_index].global_position
	travel_path.append(rand_starting_pt)
	var travel_path_size: int = 2
	for i in travel_path_size: travel_path.append(
		turning_pts[(starting_index + i + 1) % turning_pts.size()].global_position
		)
	worm.target = travel_path[0]

func move() -> void:
	worm.head.velocity = worm.head.global_position.direction_to(worm.target) * worm.speed
	worm.head.rotation = worm.head.global_position.direction_to(worm.target).angle()
	worm.head.move_and_slide()

func set_turning_pts() -> void:
	for dir in [Vector2(-1,-1), Vector2(-1,1), Vector2(1,1), Vector2(1,-1)]:
		var pt: Marker2D = Marker2D.new()
		pt.position = dir * player_offset
		turning_pts.append(pt)
		worm.enemy_component.player.add_child(pt)
