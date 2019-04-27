extends MarginContainer
var _coins = 0

func _ready():
	set_visible(true)
	$HBoxContainer/Bar3/Level/Background/Number.set_text(str(game.get_current_level()))
	$HBoxContainer/Bar1/Life/Background/Number.set_text(str(game.get_lifes_count()))
	
func _set_time_remaining(seconds_remaining):
	$HBoxContainer/Bar2/Time/Background/Seconds.set_text(str(seconds_remaining))