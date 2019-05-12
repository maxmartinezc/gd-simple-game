extends "res://worlds/environments/object-base.gd"

export (int) var trampolin_jump_percentage = 10
const MIN_SPEED = 300
export(NodePath) var gamepad_node_path = NodePath(".")
signal throw_ball(speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_body_entered(body):
	var gamepad = get_node(gamepad_node_path)
	SoundFx.play_fx("Throw")
	var shoot_speed = gamepad.shoot_speed + ( gamepad.shoot_speed * trampolin_jump_percentage/100)
	# cambiamos a IDLE el state para que nos permita genera el salto
	body.change_state(1)
	gamepad.external_shoot(shoot_speed)
