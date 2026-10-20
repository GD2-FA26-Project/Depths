extends Control

const CREATURES: Array[Dictionary] = [
	{
		"name": "Crab",
		"image": preload("res://UI/creature_log/placeholders/crab.svg"),
		"description": "A seabed creature with a hard shell and large claws.\n\nResearch notes:\nObserve its movement and attack pattern before approaching.\n\nWeak point: Not recorded."
	},
	{
		"name": "Coral",
		"image": preload("res://UI/creature_log/placeholders/coral.svg"),
		"description": "A reef organism that alternates between defending and attacking.\n\nResearch notes:\nWatch for a change in its defensive state before moving closer.\n\nWeak point: Not recorded."
	},
	{
		"name": "Worm",
		"image": preload("res://UI/creature_log/placeholders/worm.svg"),
		"description": "A long creature made up of connected body segments.\n\nResearch notes:\nKeep track of its head and the path of its trailing segments.\n\nWeak point: Not recorded."
	},
]

@onready var creature_list: ItemList = $Margin/Column/Content/CreatureList
@onready var picture: TextureRect = $Margin/Column/Content/Details/PicturePanel/Picture
@onready var creature_name: Label = $Margin/Column/Content/Details/CreatureName
@onready var description: RichTextLabel = $Margin/Column/Content/Details/Description


func _ready() -> void:
	for creature in CREATURES:
		creature_list.add_item(creature["name"])
	creature_list.select(0)
	_on_creature_selected(0)
	creature_list.grab_focus()


func _on_creature_selected(index: int) -> void:
	var creature: Dictionary = CREATURES[index]
	picture.texture = creature["image"]
	creature_name.text = creature["name"].to_upper()
	description.text = creature["description"]


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/surface_base/surface_base.tscn")
