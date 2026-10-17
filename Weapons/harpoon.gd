class_name Harpoon extends RayCast2D

##max dist that harpoon can travel before getting reeled back in  
@export var max_dist: int = 1000
var hook: Line2D
var speed: int = 20
var velocity: Vector2
var player: Player
var shoot_dir: Vector2 
var initial_pos: Vector2
var cached_position: Vector2

var foward_velocity: Vector2
var return_velocity: Vector2
var foward_rotation: float
var return_rotation: float

signal hit_made(object: Object, impact_position: Vector2)

##IDLE: the harpoon has not been shot yet
##PUSHING: the harpoon has been shot
##RETRACTING: the harpoon is getting reeled back in
enum STATE {IDLE, FLYING, RETRACTING}
var curr_state = STATE.FLYING

@warning_ignore("shadowed_variable")
func initialize(player: Player, target_pos: Vector2) -> void:
	self.player = player
	self.position = player.global_position
	self.initial_pos = player.global_position
	self.shoot_dir = initial_pos.direction_to(target_pos)
	
func _ready() -> void:
	assert(player) # breaks without player
	# godot expects Vector2.RIGHT
	foward_velocity = Vector2.RIGHT.rotated(shoot_dir.angle()) * speed
	return_velocity = Vector2.RIGHT.rotated(global_position.direction_to(player.global_position).angle()) * speed
	rotation = Vector2.RIGHT.rotated(shoot_dir.angle()).angle()
	
@warning_ignore("unused_parameter")
func _physics_process(delta: float) -> void:
	global_position += velocity
	
	if curr_state == STATE.FLYING:
		velocity = Vector2.RIGHT.rotated(shoot_dir.angle()) * speed
		rotation = Vector2.RIGHT.rotated(shoot_dir.angle()).angle()
	else:
		# returns to player
		velocity = Vector2.RIGHT.rotated(global_position.direction_to(player.global_position).angle()) * speed
	
	if is_colliding():
		var collider: Object = get_collider()
		if collider:
			hit_made.emit(collider, to_global(self.get_collision_point()))
			switch_state(STATE.RETRACTING)
		
	update_hook()
	check_distance()
	
func update_hook() -> void:
	#this draws a hook from the player to the harpoon 
	if hook: hook.queue_free()
	hook = Line2D.new()
	hook.add_point(player.global_position)
	hook.add_point(global_position)
	hook.width = 5
	get_parent().add_child(hook)
	
func switch_state(state: STATE) -> void:
	curr_state = state

func check_distance() -> void:
	if curr_state == STATE.FLYING and global_position.distance_to(cached_position) > 1000:
		switch_state(STATE.RETRACTING)
	elif curr_state == STATE.RETRACTING and global_position.distance_to(player.global_position) < 50:
		if hook: hook.queue_free()
		queue_free()
		
