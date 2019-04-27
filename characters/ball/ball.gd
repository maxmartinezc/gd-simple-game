extends RigidBody2D
export (int) var speed = 0
export (bool) var enabled_light = false
var can_shoot = true
func _ready():
	$Light2D.enabled = enabled_light
	get_parent().get_node("GUIS/Gamepad").connect("shoot", self, "_on_Gamepad_shoot")

func _on_Gamepad_shoot():
	if can_shoot:
		var stick_vector = get_parent().get_node("GUIS/Gamepad/Analog").stick_vector
		var stick_speed = get_parent().get_node("GUIS/Gamepad/Analog").stick_speed
		var stick_speed_percentage = get_parent().get_node("GUIS/Gamepad/Analog").stick_speed_percentage
		var shoot_speed = _calculate_shoot_speed(stick_speed_percentage)
		apply_impulse(Vector2(), Vector2((stick_vector.x * (stick_speed + speed/4)), shoot_speed * -1))

func _on_Ball_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("platform"):
		can_shoot = true

func _on_Ball_body_shape_exited(body_id, body, body_shape, local_shape):
	can_shoot = false

func _calculate_shoot_speed(percentage):
	return float(percentage)/100 * speed