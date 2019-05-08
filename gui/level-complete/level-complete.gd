extends Control

const TEXTURE_STARS = "res://gui/level-complete/*stars.png"
export (String) var path_scene_select_level

# Called when the node enters the scene tree for the first time.
func _ready():
	var data = game.get_level_complete()
	# nivel 1 no se muestra el current score
	if data.id > 1:
		$VBoxContainer/TextureRect/VBoxContainer/Score/General.set_text(str(game.get_score()))
	else:
		$VBoxContainer/TextureRect/VBoxContainer/Score/General.visible = false

	$VBoxContainer/TextureRect/VBoxContainer/Stars.texture = load(TEXTURE_STARS.replace("*", data.stars))
	$VBoxContainer/TextureRect/VBoxContainer/Score/Level.set_text("+" + str(data.score))

func _on_RestartButton_pressed():
	game.reload_current_level()


func _on_ContinueButton_pressed():
	get_tree().change_scene(path_scene_select_level)


func _on_ShareButton_pressed():
	print("NOT READY")
	pass # Replace with function body.
