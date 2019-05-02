extends Node2D

var seconds_remaining = 60

func _ready():
	$Ball/Health.connect("health_changed", self, "_on_Ball_health_changed")
	$GUIS/LifeLayer/Header.set_time_remaining(seconds_remaining)
	$LevelTimeOutTimer.start()

func _on_LevelTimeOutTimer_timeout():
	seconds_remaining -= 1
	$GUIS/LifeLayer/Header.set_time_remaining(seconds_remaining)
	if seconds_remaining == 0:
		$LevelTimeOutTimer.stop()
		game.game_over()

func _on_Ball_health_changed(new_health):
	$GUIS/LifeLayer/Header.set_life_bar_value(new_health)
	$Camera2D/Shaker.screen_shake(1,10,100)