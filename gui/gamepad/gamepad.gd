extends CanvasLayer

signal shoot(stick_vector, stick_speed, stick_speed_percentage, shoot_speed)
export (int) var shoot_speed = 300

func _ready():
	$Analog.connect("analog_released", self, "_on_Analog_released")
	$PowerUp.connect("activate_skill", self, "_on_Active_skill")

func _on_Analog_released(stick_vector, stick_speed, stick_speed_percentage):
	emit_signal("shoot", stick_vector, stick_speed, stick_speed_percentage, shoot_speed)

func external_shoot(speed):
	_shoot(speed)

func _shoot(speed):
	var stick_vector = $Analog.stick_vector
	if stick_vector.y < 0:
		emit_signal("shoot", stick_vector, $Analog.stick_speed, $Analog.stick_speed_percentage, speed)
		
func _on_Active_skill():
	get_parent().get_node("Header").set_coins(game.get_coins())