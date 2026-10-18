@tool
## this is an enemy comprised of several segments
class_name Worm extends Node2D

@export var enemy_component: EnemyComponent
@onready var segments_root: Node2D = $Segments
var segments: Array[WormSegment] = []

var num_segments: int = 50
var speed: int = 1000
var segment_length: int = 64

const WORM_SEGMENT = preload("uid://bx7p8ckb4pj6e")

@export var head: WormSegment = null
var target: Vector2

## This a button used to visualize segments in the editor
@export_tool_button("AddSegments") var restack_button: Callable = editor_add_segments

@warning_ignore("shadowed_variable")
func initialize(player: Player) -> void:
	enemy_component.initialize(player, WormTravel)
	enemy_component.state_machine.setup(self)
	enemy_component.state_machine.change_state(enemy_component.initial_state)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	add_segments()
	#enemy_component.stun_manager.reparent(head)
	
 
@warning_ignore("unused_parameter")
func _physics_process(delta):
	if Engine.is_editor_hint():
		return
	enemy_component.state_machine.physics_update(delta)
	
func add_segments() -> void:
	for child in segments_root.get_children():
		child.queue_free()
	
	segments.clear()
	
	# creates segments in a chain by using "next" and making them equal distance from each other
	for i in num_segments:
		var worm_seg: WormSegment =  WORM_SEGMENT.instantiate()
		worm_seg.initialize(self, speed, segment_length, segment_length)
		segments.append(worm_seg)
		if i != 0: 
			worm_seg.next = segments[i - 1] 
		worm_seg.position.x += segment_length * i 
		segments_root.add_child(worm_seg)
		# this line with the tool button helps create the nodes in the editor
		worm_seg.owner = get_tree().edited_scene_root
	
	if !segments.is_empty(): 
		head = segments[0]
	
func editor_add_segments() -> void:
	if Engine.is_editor_hint():
		add_segments()
	

	
	
	
