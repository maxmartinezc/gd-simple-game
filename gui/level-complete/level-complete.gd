extends Control

const TEXTURE_STARS = "res://gui/level-complete/*stars.png"
export (String) var path_scene_select_level

# Called when the node enters the scene tree for the first time.
func _ready():
	var data = game.get_level_complete()
	$VBoxContainer/TextureRect/VBoxContainer/Stars.texture = load(TEXTURE_STARS.replace("*", data.stars))
	$VBoxContainer/TextureRect/VBoxContainer/Points/Level/Amount.set_text("+" + str(data.score))
	$VBoxContainer/TextureRect/VBoxContainer/Points/Score/Amount.set_text("+" + str(data.coins))

func _on_RestartButton_pressed():
	game.reload_current_level()

func _on_ContinueButton_pressed():
	get_tree().change_scene(path_scene_select_level)

func _on_ShareButton_pressed():
	print("NOT READY")