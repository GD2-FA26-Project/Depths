@tool
## this is an enemy comprised of several segments
class_name Worm extends Node2D

@export var segments: Array[WormSegment] = []

var turning_pts: Array[Marker2D]
var travel_path: Array[Vector2]

var player: Player
var prev_player_pos: Vector2
var player_offset: int = 600

var num_segments: int = 50
var speed: int = 800
var segment_length: int = 64


const WORM_SEGMENT = preload("uid://bx7p8ckb4pj6e")
# temporary
const EXTRACTION_POINT = preload("uid://cnyt1wjqydkuv")


@export var head: WormSegment = null
var target: Vector2

##travel: worm moves between points on the map
##chase: worm targets the player
enum STATE {TRAVEL, CHASE}
var curr_state: STATE = STATE.TRAVEL

## This a button used to visualize segments in the editor
@export_tool_button("AddSegments") var restack_button: Callable = add_segments

@warning_ignore("shadowed_variable")
func initialize(player: Player) -> void:
	self.player = player

func set_turning_pts() -> void:
	for dir in [Vector2(-1,-1), Vector2(-1,1), Vector2(1,1), Vector2(1,-1)]:
		print("hey?")
		var pt: Marker2D = Marker2D.new()
		pt.position = dir * player_offset
		turning_pts.append(pt)
		player.add_child(pt)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	add_segments()
	WormSegment.initialize(speed, segment_length, segment_length)
	set_turning_pts()
	populate_travel_path()
 
func _input(event):
	# placeholder, worm will move on it's own in the actual game
	if event.is_action_pressed("ui_accept"):
		target = get_global_mouse_position()
		
@warning_ignore("unused_parameter")
func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	# worm controller only needs to move and rotate the head. others will follow
	head.velocity = head.global_position.direction_to(target) * speed
	head.rotation = head.global_position.direction_to(target).angle()
	if head.global_position.distance_to(target) < 10:
		if curr_state == STATE.TRAVEL:
			travel_path.pop_front()
			if !travel_path.is_empty(): target = travel_path[0]
			else: switch_state(STATE.CHASE)
		else:
			switch_state(STATE.TRAVEL)
			
	head.move_and_slide()
	print(curr_state)
	
func add_segments() -> void:
	for child in get_children():
		child.queue_free()
	
	segments.clear()
	
	# creates segments in a chain by using "next" and making them equal distance from each other
	for i in num_segments:
		var worm_seg: WormSegment =  WORM_SEGMENT.instantiate()
		segments.append(worm_seg)
		if i != 0: 
			worm_seg.next = segments[i - 1] 
		worm_seg.position.x += segment_length * i 
		add_child(worm_seg)
		# this line with the tool button helps create the nodes in the editor
		worm_seg.owner = get_tree().edited_scene_root
	
	if !segments.is_empty(): 
		head = segments[0]
	
	# temporary
	var extra_p: ExtractionPoint = EXTRACTION_POINT.instantiate()
	head.add_child(extra_p)

func switch_state(new_state: STATE) -> void:
	self.curr_state = new_state
	if curr_state == STATE.TRAVEL:
		populate_travel_path()
	else:
		chase()
	
func populate_travel_path() -> void:
	var starting_index: int = randi_range(0, turning_pts.size() - 2)
	var rand_starting_pt: Vector2 = turning_pts[starting_index].global_position
	travel_path.append(rand_starting_pt)
	var travel_path_size: int = 2
	for i in travel_path_size: travel_path.append(
		turning_pts[(starting_index + i + 1) % turning_pts.size()].global_position
		)
	travel()

func travel() -> void:
	target = travel_path[0]

func chase() -> void:
	target = player.global_position
	
	
	
	
	
