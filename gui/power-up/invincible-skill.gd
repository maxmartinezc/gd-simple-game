extends "res://gui/power-up/skill.gd"

var time_invulnerability = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _validate():
	return true

func get_skill():
	var success = _validate()
	if success:
		SoundFx.play_fx("PowerUp")
		get_tree().get_current_scene().get_node("Player/Health").set_invincible(time_invulnerability)
	else:
		skill_not_ready()
	return success