extends Control
export (String) var path_scene_select_level

func _ready():
	visible = false

func show():
	SoundFx.play_fx("Death")
	SoundFx.stop_background()
	get_tree().paused = true
	visible = true

func _on_ExitButton_pressed():
	SoundFx.play_fx("Switchy")
	get_tree().paused = false
	get_tree().change_scene(path_scene_select_level)

func _on_RestartButton_pressed():
	SoundFx.play_fx("Switchy")
	get_tree().paused = false
	game.reload_current_level()