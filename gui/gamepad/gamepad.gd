extends CanvasLayer

signal shoot(stick_vector, stick_speed, stick_speed_percentage)

func _input(event):
	if event.is_action_pressed("shoot"):
		_on_ShootButton_pressed()
		
func _on_ShootButton_pressed():
	var stick_vector = $Analog.stick_vector
	if stick_vector.y < 0:
		emit_signal("shoot", stick_vector, $Analog.stick_speed, $Analog.stick_speed_percentage)