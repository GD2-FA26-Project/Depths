class_name SubmarineGun extends RayCast2D

var velocity: Vector2

func initialize(position: Vector2, velocity: Vector2, rotation: float) -> void:
	self.position = position
	self.velocity = velocity
	self.rotation = rotation 

func _physics_process(delta: float) -> void:
	position += velocity
