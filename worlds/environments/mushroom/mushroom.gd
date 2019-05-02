extends "res://worlds/environments/object-base.gd"

export (int) var trampolin_jump_percentage = 10
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Mushroom_body_entered(body):
	var ball = body
	var ball_speed = ball.speed
	ball.shoot(ball_speed + (ball.speed * trampolin_jump_percentage/100))
