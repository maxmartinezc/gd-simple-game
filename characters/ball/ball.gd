extends RigidBody2D
export (int) var speed = 0
export (bool) var enabled_light = false
var can_shoot = true
signal death()

func _ready():
	$Light2D.enabled = enabled_light
	get_parent().get_node("GUIS/Gamepad").connect("shoot", self, "_on_Gamepad_shoot")
	$Health.connect("take_damage", self, "_on_Health_take_damage")

func _on_Gamepad_shoot():
	if can_shoot:
		shoot(speed)

func _on_Ball_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("platform"):
		can_shoot = true
	elif body.name == 'Right':
		apply_impulse(Vector2(), Vector2(-10, 0))
	elif body.name == 'Left':
		apply_impulse(Vector2(), Vector2(10, 0))

func _on_Ball_body_shape_exited(body_id, body, body_shape, local_shape):
	can_shoot = false

func shoot(_speed):
	var stick_vector = get_parent().get_node("GUIS/Gamepad/Analog").stick_vector
	# solo se dispara si el stick.y esta siendo apuntada hacia arriba 
	# controla que no permite disparar si esta apuntando hacia abajo
	if stick_vector.y < 0:
		var stick_speed = get_parent().get_node("GUIS/Gamepad/Analog").stick_speed
		var stick_speed_percentage = get_parent().get_node("GUIS/Gamepad/Analog").stick_speed_percentage
		var shoot_speed = float(stick_speed_percentage)/100 * _speed
		SoundFx.play_fx("Jump")
		apply_impulse(Vector2(), Vector2((stick_vector.x * (stick_speed + _speed/4)), shoot_speed * -1))

func _on_Health_take_damage(new_health):
	if new_health == 0:
		emit_signal("death")