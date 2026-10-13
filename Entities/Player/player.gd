class_name Player extends CharacterBody2D

@export var speed: int = 400
signal shot_made
	
func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shoot_harpoon"):
		shot_made.emit()
		
	#WASD movement
	var input = Input.get_vector("left", "right", "up", "down")
	velocity = input * speed
	move_and_slide()
		
	
