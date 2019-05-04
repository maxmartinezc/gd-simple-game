extends Node2D

var seconds_remaining = 60

func _ready():
	$Ball/Health.connect("health_changed", self, "_on_Ball_health_changed")
	$Ball.connect("death", self, "_on_Ball_death")
	$GUIS/LifeLayer/Header.set_time_remaining(seconds_remaining)
	$LevelTimeOutTimer.start()

func _on_LevelTimeOutTimer_timeout():
	seconds_remaining -= 1
	$GUIS/LifeLayer/Header.set_time_remaining(seconds_remaining)
	if seconds_remaining == 0:
		$LevelTimeOutTimer.stop()
		$GUIS/MenuLayer/GameOver.show()

func _on_Ball_health_changed(new_health):
	$GUIS/LifeLayer/Header.set_life_bar_value(new_health)
	$Camera2D/Shaker.screen_shake(1,10,100)

func _on_Ball_death():
	$GUIS/MenuLayer/GameOver.show()

func _on_Top_body_entered(body):
	SoundFx.play_fx("Hit")
	body.get_node("Health").take_damage(10)
