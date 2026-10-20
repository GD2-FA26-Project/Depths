@tool
class_name Core extends Area2D

## the enemy or entity who has the core
var core_owner: Node
## false by default, true when harpoon is harvesting the core.
## ensures the same core isn't extracted multiple times per frame.
var extracted: bool = false

func _ready() -> void:
	assert(core_owner)

func initialize(owner: Node) -> void:
	self.core_owner = owner

func _draw() -> void:
	draw_circle(Vector2.ZERO, 24, Color(1.0, 0.0, 0.737, 0.502))
