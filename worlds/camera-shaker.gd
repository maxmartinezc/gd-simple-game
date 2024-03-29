extends Node

onready var camera = get_parent()

var current_shake_priority = 0

# Called when the node enters the scene tree for the first time.
func move_camera(vector):
	camera.offset = Vector2(rand_range(-vector.x, vector.x), rand_range(-vector.y, vector.y))
	
func screen_shake(shake_length, shake_power, shake_priority):
	if shake_priority > current_shake_priority:
		current_shake_priority = shake_priority
		$Tween.interpolate_method(self, 
			"move_camera", 
			Vector2(shake_power, shake_power), 
			Vector2(0,0),
			shake_length,
			Tween.TRANS_SINE,
			Tween.EASE_OUT, 
			0
		)
		$Tween.start()

func _on_Tween_tween_completed(object, key):
	current_shake_priority = 0
