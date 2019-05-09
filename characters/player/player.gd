extends Node2D
export (int) var speed = 300
signal death()

func _ready():
	$Ball.set_speed(speed)
	get_parent().get_node("GUIS/Gamepad").connect("shoot", $Ball, "_on_Gamepad_shoot")
#	$Health.connect("take_damage", self, "_on_Health_take_damage")
#	$Health.connect("invincible", self, "_on_Player_invincible")

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

#func _on_Health_take_damage(new_health):
#	if new_health == 0:
#		emit_signal("death")
#	else:
#		$AnimatedSprite.play("damage")
#
#func _on_Player_invincible(value):
#	if value:
#		$AnimatedSprite.play("invincible")