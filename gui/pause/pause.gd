extends CanvasLayer
export (String) var path_scene_select_level

func _ready():
	$Control.set_visible(false)
	
func _input(event):
	if event.is_action_pressed("pause"):
		_pause()

func _on_ResumeButton_pressed():
	_pause()
	
func _pause():
	var new_pause_state = not get_tree().paused
	get_tree().paused = new_pause_state
	$Control.visible = new_pause_state

func _on_RestartButton_pressed():
	SoundFx.play_fx("Switchy")
	_pause()
	game.reload_current_level()
	#get_tree().reload_current_scene()

func _on_ExitButton_pressed():
	SoundFx.play_fx("Switchy")
	_pause()
	SoundFx.stop_background()
	get_tree().change_scene(path_scene_select_level)
