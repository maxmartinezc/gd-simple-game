extends Area2D

export (int) var time_invulnerability = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Potion_body_entered(body):
	if body.has_node("Health"):
		SoundFx.play_fx("PowerUp")
		body.get_node("Health").set_invincible(time_invulnerability)
		queue_free()