class_name CellMap extends Control

var cells: Array[Vector2i] = []
var current_cell: Vector2i


func _ready() -> void:
	resized.connect(queue_redraw)


func set_cells(layout: Array[Vector2i], player_cell: Vector2i) -> void:
	cells = layout.duplicate()
	current_cell = player_cell
	queue_redraw()


func _draw() -> void:
	if cells.is_empty():
		return
	var minimum: Vector2i = cells[0]
	var maximum: Vector2i = cells[0]
	for cell in cells:
		minimum = minimum.min(cell)
		maximum = maximum.max(cell)
	var span := Vector2(maximum - minimum + Vector2i.ONE)
	var pitch: float = maxf(1.0, minf(180.0, minf((size.x - 80.0) / span.x, (size.y - 80.0) / span.y)))
	var origin: Vector2 = (size - span * pitch) / 2.0
	var rectangles: Dictionary = {}
	for cell in cells:
		var position_in_map: Vector2 = origin + Vector2(cell - minimum) * pitch + Vector2.ONE * pitch * 0.18
		rectangles[cell] = Rect2(position_in_map, Vector2.ONE * pitch * 0.64)

	# Adjacent grid cells are connected in this draft layout.
	for cell in cells:
		var rectangle: Rect2 = rectangles[cell]
		for direction in [Vector2i.RIGHT, Vector2i.DOWN]:
			var neighbor: Vector2i = cell + direction
			if rectangles.has(neighbor):
				var neighbor_rect: Rect2 = rectangles[neighbor]
				draw_line(rectangle.get_center(), neighbor_rect.get_center(), Color(0.7, 0.7, 0.7), 6.0)

	var font: Font = get_theme_default_font()
	var font_size: int = 28
	for index in range(cells.size()):
		var rectangle: Rect2 = rectangles[cells[index]]
		var is_current: bool = cells[index] == current_cell
		var fill := Color(0.9, 0.9, 0.9) if is_current else Color(0.3, 0.3, 0.3)
		draw_rect(rectangle, fill)
		draw_rect(rectangle, Color.WHITE if is_current else Color(0.65, 0.65, 0.65), false, 3.0)
		var text: String = "YOU" if is_current else str(index + 1)
		var text_width: float = font.get_string_size(text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size).x
		var baseline: Vector2 = rectangle.get_center() + Vector2(-text_width / 2.0, (font.get_ascent(font_size) - font.get_descent(font_size)) / 2.0)
		draw_string(font, baseline, text, HORIZONTAL_ALIGNMENT_LEFT, -1, font_size, Color.BLACK if is_current else Color.WHITE)
