extends "res://worlds/environments/object-base.gd"

export (int) var trampolin_jump_percentage = 10
const MIN_SPEED = 300

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Mushroom_body_entered(body):
	SoundFx.play_fx("Throw")
	var ball = body
	var shoot_speed = ball.speed + (ball.speed * trampolin_jump_percentage/100)
	print(shoot_speed)
	ball.shoot(shoot_speed)
