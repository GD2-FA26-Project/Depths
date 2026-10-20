extends Control


func _ready() -> void:
	$VBoxContainer/NewGameButton.grab_focus()
	$SettingsDialog/VBoxContainer/VolumeSlider.set_value_no_signal(db_to_linear(AudioServer.get_bus_volume_db(0)) * 100.0)
	$SettingsDialog/VBoxContainer/FullscreenToggle.set_pressed_no_signal(DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://UI/surface_base/surface_base.tscn")


func _on_settings_pressed() -> void:
	$SettingsDialog.popup_centered()


func _on_volume_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, linear_to_db(maxf(value / 100.0, 0.001)))
	AudioServer.set_bus_mute(0, is_zero_approx(value))


func _on_fullscreen_toggled(enabled: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if enabled else DisplayServer.WINDOW_MODE_WINDOWED)
