extends Node2D
signal death()
export (bool) var enabled_light = false

func _ready():
	get_parent().get_node("GUIS/Gamepad").connect("shoot", $Ball, "_on_Gamepad_shoot")
	$Ball/Light2D.enabled = enabled_light

#func _on_Gamepad_shoot():
#	if can_shoot:
#		shoot(speed)


#func shoot(_speed):
#	var analog = get_parent().get_node("GUIS/Gamepad/Analog")
#	var stick_vector = analog.stick_vector
#	# solo se dispara si el stick.y esta siendo apuntada hacia arriba 
#	# controla que no permite disparar si esta apuntando hacia abajo
#	if stick_vector.y < 0:
#		var stick_speed = analog.stick_speed
#		var stick_speed_percentage = analog.stick_speed_percentage
#		var shoot_speed = float(stick_speed_percentage)/100 * _speed
#		SoundFx.play_fx("Jump")
#		$Ball.apply_impulse(Vector2(), Vector2((stick_vector.x * (stick_speed + _speed/4)), shoot_speed * -1))