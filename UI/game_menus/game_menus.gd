class_name GameMenus extends CanvasLayer

signal map_opened
signal menu_opened

@onready var map_menu: Control = $MapMenu
@onready var pause_menu: Control = $PauseMenu
@onready var cell_map: CellMap = $MapMenu/Margin/Column/MapPanel/CellMap
@onready var current_cell_label: Label = $MapMenu/Margin/Column/Info/CurrentCell
@onready var objectives_label: Label = $PauseMenu/Margin/Column/Content/Objectives/Margin/Column/Scroll/ObjectivesText
@onready var items_list: ItemList = $PauseMenu/Margin/Column/Content/Items/Margin/Column/ItemsList
@onready var depth_label: Label = $PauseMenu/Margin/Column/Stats/Depth
@onready var resources_label: Label = $PauseMenu/Margin/Column/Stats/Resources


func _ready() -> void:
	# Connect inside the scene instances here so Godot editor saves keep them.
	$MapMenu/Margin/Column/Footer/CloseButton.pressed.connect(close_menus)
	$PauseMenu/Margin/Column/Buttons/ResumeButton.pressed.connect(close_menus)
	$PauseMenu/Margin/Column/Buttons/MapButton.pressed.connect(open_map)
	$PauseMenu/Margin/Column/Buttons/SurfaceButton.pressed.connect(_return_to_surface)
	map_menu.hide()
	pause_menu.hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_map"):
		get_viewport().set_input_as_handled()
		if map_menu.visible:
			close_menus()
		else:
			open_map()
	elif event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		if map_menu.visible or pause_menu.visible:
			close_menus()
		else:
			open_menu()


func open_map() -> void:
	get_tree().paused = true
	map_opened.emit()
	pause_menu.hide()
	map_menu.show()
	$MapMenu/Margin/Column/Footer/CloseButton.grab_focus()


func open_menu() -> void:
	get_tree().paused = true
	menu_opened.emit()
	map_menu.hide()
	pause_menu.show()
	$PauseMenu/Margin/Column/Buttons/ResumeButton.grab_focus()


func close_menus() -> void:
	map_menu.hide()
	pause_menu.hide()
	get_tree().paused = false


func update_map(cells: Array[Vector2i], player_cell: Vector2i) -> void:
	cell_map.set_cells(cells, player_cell)
	var index: int = cells.find(player_cell)
	current_cell_label.text = "Current cell: %d" % (index + 1) if index >= 0 else "Outside mapped cells"


func update_menu(objectives: PackedStringArray, items: PackedStringArray, depth: float, resources: int) -> void:
	objectives_label.text = "\n\n".join(objectives) if not objectives.is_empty() else "No current objectives."
	items_list.clear()
	if items.is_empty():
		items_list.add_item("No items collected yet.")
		items_list.set_item_selectable(0, false)
	else:
		for item in items:
			items_list.add_item(item)
	depth_label.text = "Depth: %d m" % roundi(maxf(depth, 0.0))
	resources_label.text = "Resources: %d" % maxi(resources, 0)


func _return_to_surface() -> void:
	var tree: SceneTree = get_tree()
	# The base needs to process normally after the gameplay scene is replaced.
	tree.paused = false
	var error: Error = tree.change_scene_to_file("res://UI/surface_base/surface_base.tscn")
	if error != OK:
		tree.paused = true
		push_error("Could not open the surface base: %s" % error_string(error))
