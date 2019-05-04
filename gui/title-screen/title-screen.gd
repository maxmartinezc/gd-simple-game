extends Control

export (String) var path_scene_select_level

func _ready():
	SoundFx.play_background("Menu")
	
func _on_QuitButton_pressed():
	SoundFx.play_fx("Switchy")
	get_tree().quit()

func _on_PlayGameButton2_pressed():
	SoundFx.play_fx("Switchy")
	get_tree().change_scene(path_scene_select_level)
