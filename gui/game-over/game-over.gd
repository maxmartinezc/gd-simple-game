extends Control
export (String) var path_scene_select_level

func _on_ExitButton_pressed():
	get_tree().change_scene(path_scene_select_level)

func _on_RestartButton_pressed():
	game.reload_current_level()