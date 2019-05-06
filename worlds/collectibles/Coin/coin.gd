extends Area2D
export (int) var amount = 1
signal collect_coin(amount)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.playing = true

func _on_Coin_body_entered(body):
	if body.name == "Ball":
		SoundFx.play_fx("Coin")
		emit_signal("collect_coin", amount)
		queue_free()
