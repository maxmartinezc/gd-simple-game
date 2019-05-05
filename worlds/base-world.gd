extends Node2D

func _ready():
	$Ball/Health.connect("take_damage", self, "_on_Ball_take_damage")
	$Ball/Health.connect("recover_health", self, "_on_Health_recover_health")
	$Ball.connect("death", self, "_on_Ball_death")
	$GUIS/LifeLayer/Header.connect("time_out", self, "level_time_out")

func level_time_out():
	$GUIS/MenuLayer/GameOver.show()
	
func _on_Ball_take_damage(new_health):
	$GUIS/LifeLayer/Header.set_life_bar_value(new_health)
	$Camera2D/Shaker.screen_shake(1,10,100)
	
func _on_Health_recover_health(new_health):
	$GUIS/LifeLayer/Header.set_life_bar_value(new_health)
	
func _on_Ball_death():
	$GUIS/MenuLayer/GameOver.show()

func _on_Top_body_entered(body):
	SoundFx.play_fx("Hit")
	body.get_node("Health").take_damage(10)
