extends Area2D

export (int) var recovery_amount = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Health_body_entered(body):
	if body.get_parent().has_node("Health"):
		var health = body.get_node("../Health")
		if health.get_health() < health.get_max_health():
			SoundFx.play_fx("PowerUp")
			body.get_node("../Health").recover_health(recovery_amount)
			queue_free()
