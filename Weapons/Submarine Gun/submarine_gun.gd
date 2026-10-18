class_name SubmarineGun extends RayCast2D

var velocity: Vector2
signal hit_made(object: Object, collision_pt)

func initialize(position: Vector2, velocity: Vector2, rotation: float) -> void:
	self.position = position
	self.velocity = velocity
	self.rotation = rotation 

func _physics_process(delta: float) -> void:
	position += velocity
	
	if is_colliding():
		var collider: Object = get_collider()
		if collider:
			hit_made.emit(collider, to_global(self.get_collision_point()))
			queue_free()
