extends RigidBody2D
export (int) var speed = 0
export (bool) var enabled_light = false
var can_shoot = true
const DAMAGE_JUMP_X = 30.5
const DAMAGE_JUMP_HEIGHT = 150

func _ready():
	$Light2D.enabled = enabled_light
	get_parent().get_node("GUIS/Gamepad").connect("shoot", self, "_on_Gamepad_shoot")
	$Health.connect("health_changed", self, "_on_Health_health_changed")
	$Health.connect("state_changed", self, "_on_Health_health_changed")

func _on_Gamepad_shoot():
	if can_shoot:
		shoot(speed)

func _on_Ball_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("platform"):
		can_shoot = true
	elif body.is_in_group("enemy"):
		var jump_x_position = DAMAGE_JUMP_X
		if body.position.x > position.x:
			jump_x_position *= -1
	
		apply_impulse(Vector2(), Vector2(jump_x_position, DAMAGE_JUMP_HEIGHT * -1))
		$Health.take_damage(body.get_damage())
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
		apply_impulse(Vector2(), Vector2((stick_vector.x * (stick_speed + _speed/4)), shoot_speed * -1))
	
func _on_Health_health_changed(new_health):
	if new_health == 0:
		game.game_over()