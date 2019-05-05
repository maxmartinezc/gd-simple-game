extends Area2D

export (int) var recovery_amount = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Potion_body_entered(body):
	if body.has_node("Health"):
		var health = body.get_node("Health")
		if health.get_health() < health.get_max_health():
			SoundFx.play_fx("PowerUp")
			body.get_node("Health").recover_health(recovery_amount)
			queue_free()
	
