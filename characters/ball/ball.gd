extends RigidBody2D

var can_shoot = true
func _ready():
	get_parent().get_node("GUIS/Gamepad").connect("shoot", self, "_on_Gamepad_shoot")

func _on_Gamepad_shoot(speed):
	if can_shoot:
		var stick_vector = get_parent().get_node("GUIS/Gamepad/Analog").stick_vector
		var stick_speed = get_parent().get_node("GUIS/Gamepad/Analog").stick_speed
		apply_impulse(Vector2(), Vector2((stick_vector.x * (stick_speed + speed/4)), speed * -1))

func _on_Ball_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("platform"):
		can_shoot = true

func _on_Ball_body_shape_exited(body_id, body, body_shape, local_shape):
	can_shoot = false
