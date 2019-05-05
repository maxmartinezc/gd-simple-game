extends MarginContainer

export (int) var seconds_remaining = 60
var seconds_to_blink_time = 10

signal time_out()

func _ready():
	_setup()
	$TimeOutTimer.start()
	
func set_life_bar_value(new_health):
	$HBoxContainer/Bar1/TextureProgress.value = new_health

func _on_TimerTimeOut_timeout():
	seconds_remaining -= 1
	$HBoxContainer/Bar2/Time/Background/Seconds.set_text(str(seconds_remaining))
	if seconds_remaining == 0:
		$TimeOutTimer.stop()
		$BlinkSecondsTimer.stop()
		emit_signal("time_out")
	elif seconds_remaining == seconds_to_blink_time:
		SoundFx.play_fx("HurryUp")
		$BlinkSecondsTimer.start()
		
func _setup():
	set_visible(true)
	var world_level = game.get_current_level()
	$BlinkSecondsTimer.wait_time = 0.5
	$TimeOutTimer.wait_time = 1
	$HBoxContainer/Bar2/Time/Background/Seconds.set_text(str(seconds_remaining))
	$HBoxContainer/Bar3/Level/Background/Number.set_text(str(world_level.world) + "-" + str(world_level.level))
	$HBoxContainer/Bar1/TextureProgress.max_value = game.get_max_health()
	$HBoxContainer/Bar1/TextureProgress.value = game.get_max_health()

func _on_BlinkSecondsTimer_timeout():
	$HBoxContainer/Bar2/Time/Background/Seconds.visible = !$HBoxContainer/Bar2/Time/Background/Seconds.visible
