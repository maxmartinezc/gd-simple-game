extends RigidBody2D

export (int) var damage = 5
const DAMAGE_JUMP_X = 30.5
const DAMAGE_JUMP_HEIGHT = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_damage():
	return damage
	
func _on_BaseEnemy_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.name == 'Ball':
		var jump_x_position = DAMAGE_JUMP_X
		if body.position.x < position.x:
			jump_x_position *= -1
		
		body.apply_impulse(Vector2(), Vector2(jump_x_position, DAMAGE_JUMP_HEIGHT * -1))
		body.get_node("../Health").take_damage(damage)
