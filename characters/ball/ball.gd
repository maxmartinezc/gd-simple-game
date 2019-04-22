extends RigidBody2D

func _ready():
	get_parent().get_node("GUIS/ButtonsLayer/Gamepad").connect("shoot", self, "_on_Gamepad_shoot")
	
func _on_Gamepad_shoot(speed):
	apply_impulse(Vector2(), Vector2(0, speed * -1))
