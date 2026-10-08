@tool
## this is an enemy comprised of several segments
class_name Worm extends Node2D

@export var segments: Array[WormSegment] = []
var num_segments: int = 10
var speed: int = 400
var segment_length: int = 64

const WORM_SEGMENT = preload("uid://bx7p8ckb4pj6e")
# temporary
const EXTRACTION_POINT = preload("uid://cnyt1wjqydkuv")

@export var head: WormSegment = null
var target: Vector2

## This a button used to visualize segments in the editor
@export_tool_button("AddSegments") var restack_button: Callable = add_segments

## creates and initializes all chains
func _ready() -> void:
	add_segments()
	target = head.position
	WormSegment.initialize(speed, segment_length, num_segments * segment_length)

func _input(event):
	# placeholder, worm will move on it's own in the actual game
	if event.is_action_pressed("ui_accept"):
		target = get_global_mouse_position()
		
func _physics_process(delta):
	# worm controller only needs to move and rotate the head. others will follow
	head.velocity = head.global_position.direction_to(target) * speed
	head.rotation = head.global_position.direction_to(target).angle()
	if head.global_position.distance_to(target) > 10:
		head.move_and_slide()

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
	var extra_p: WeakPoint = EXTRACTION_POINT.instantiate()
	head.add_child(extra_p)
	

	
	
	
	
