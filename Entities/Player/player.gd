class_name Player extends CharacterBody2D

@export var speed: int = 400
	
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	#WASD movement
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	move_and_slide()
