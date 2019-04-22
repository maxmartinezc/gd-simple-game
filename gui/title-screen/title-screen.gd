extends Control

export (String) var path_scene_select_level

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_PlayGameButton2_pressed():
	get_tree().change_scene(path_scene_select_level)
