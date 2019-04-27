extends Node2D

export (String) var path_scene_game_over
var seconds_remaining = 60

func _ready():
	$GUIS/LifeLayer/Header._set_time_remaining(seconds_remaining)
	$LevelTimeOutTimer.start()

func _on_LevelTimeOutTimer_timeout():
	seconds_remaining -= 1
	$GUIS/LifeLayer/Header._set_time_remaining(seconds_remaining)
	if seconds_remaining == 0:
		$LevelTimeOutTimer.stop()
		_finished_level()

func _finished_level():
	get_tree().change_scene(path_scene_game_over)
