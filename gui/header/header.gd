extends MarginContainer

export (int) var seconds_remaining = 60
var seconds_to_blink_time = 10

signal time_out()

func _ready():
	_setup()
	$TimeOutTimer.start()
	
func set_life_bar_value(new_health):
	$HBoxContainer/Bar1/Progress/TextureProgress.value = new_health

func set_coins(amount):
	$HBoxContainer/Bar1/Progress/Score/Title.set_text(str(amount))
	
func _on_TimerTimeOut_timeout():
	seconds_remaining -= 1
	$HBoxContainer/Bar3/NinePatchRect/Seconds.set_text(str(seconds_remaining))
	if seconds_remaining == 0:
		$TimeOutTimer.stop()
		$BlinkSecondsTimer.stop()
		emit_signal("time_out")
	elif seconds_remaining == seconds_to_blink_time:
		SoundFx.play_fx("HurryUp")
		$HBoxContainer/Bar3/NinePatchRect/Seconds.add_color_override("font_color", Color.red)
		$BlinkSecondsTimer.start()
		
func _setup():
	set_visible(true)
	var world_level = game.get_current_level()
	$BlinkSecondsTimer.wait_time = 0.5
	$TimeOutTimer.wait_time = 1
	$HBoxContainer/Bar3/NinePatchRect/Seconds.set_text(str(seconds_remaining))
	$HBoxContainer/Bar1/Progress/Score/LevelNumber.set_text(str(world_level.world) + "-" + str(world_level.level))
	$HBoxContainer/Bar1/Progress/TextureProgress.max_value = game.get_max_health()
	$HBoxContainer/Bar1/Progress/TextureProgress.value = game.get_max_health()

func _on_BlinkSecondsTimer_timeout():
	$HBoxContainer/Bar3/NinePatchRect/Seconds.visible = !$HBoxContainer/Bar3/NinePatchRect/Seconds.visible

func increase_timeout(increase_time):
	SoundFx.stop_fx("HurryUp")
	$TimeOutTimer.stop()
	$BlinkSecondsTimer.stop()
	$HBoxContainer/Bar3/NinePatchRect/Seconds.add_color_override("font_color", Color.white)
	seconds_remaining += increase_time
	$HBoxContainer/Bar3/NinePatchRect/Seconds.set_text(str(seconds_remaining))
	$HBoxContainer/Bar3/NinePatchRect/Seconds.visible = true
	$TimeOutTimer.start()