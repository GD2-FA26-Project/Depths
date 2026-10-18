@tool
## this class controls a worm segments following behaviour
class_name WormSegment extends CharacterBody2D

var worm_owner: Worm
var next: WormSegment = null

var speed: int
var follow_dist: int
var length: int

## makes stats consistent for all segments
func initialize(worm_owner: Worm, worm_speed: int, worm_follow_dist: int, worm_length: int) -> void:
	self.worm_owner = worm_owner
	speed = worm_speed
	follow_dist = worm_follow_dist
	length = worm_length

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if next:
		var next_dir: Vector2 = self.position.direction_to(next.position)
		rotation = next_dir.angle()
		if self.position.distance_to(next.position) > follow_dist:
			velocity = transform.x * speed
		else:
			velocity = Vector2.ZERO
		
		move_and_slide()
		
	
