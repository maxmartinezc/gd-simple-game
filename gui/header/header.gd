extends MarginContainer
var _coins = 0

func _ready():
	set_visible(true)
	#var c = get_tree().current_scene
	#c.get_node("Hole").connect("go_in", self, "add_to_coins")
	$HBoxContainer/Bar1/Score/Background/Number.set_text(str(game.get_score()))
	$HBoxContainer/Bar2/Level/Background/Number.set_text(str(game.get_current_level()))