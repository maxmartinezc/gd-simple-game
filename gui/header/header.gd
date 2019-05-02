extends MarginContainer
var _coins = 0

func _ready():
	set_visible(true)
	var world_level = game.get_current_level()
	$HBoxContainer/Bar3/Level/Background/Number.set_text(str(world_level.world) + "-" + str(world_level.level))
	$HBoxContainer/Bar1/TextureProgress.max_value = game.get_max_health()
	$HBoxContainer/Bar1/TextureProgress.value = game.get_max_health()
	
func set_time_remaining(seconds_remaining):
	$HBoxContainer/Bar2/Time/Background/Seconds.set_text(str(seconds_remaining))
	
func set_life_bar_value(new_health):
	$HBoxContainer/Bar1/TextureProgress.value = new_health

