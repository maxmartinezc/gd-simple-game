extends CanvasLayer

signal shoot

func _input(event):
	if event.is_action_pressed("shoot"):
		_on_ShootButton_pressed()
		
func _on_ShootButton_pressed():
	emit_signal("shoot")