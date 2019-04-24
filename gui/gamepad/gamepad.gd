extends CanvasLayer

export (int) var max_speed = 0

signal shoot(speed)

func _input(event):
	if event.is_action_pressed("shoot"):
		_on_ShootButton_pressed()
		
func _on_ShootButton_pressed():
	emit_signal("shoot", max_speed)