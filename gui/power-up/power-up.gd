extends Node2D

signal activate_skill

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self, "_on_Button_pressed", [button])
		button.get_node("../Coins/Amount").set_text(str(button.get_parent().coins_required))

func _on_Button_pressed(button):
	var coins_required = int(button.get_node("../Coins/Amount").get_text())
	if game.get_coins() >= coins_required:
		var success = button.get_parent().get_skill()
		if success:
			game.use_coins(coins_required)
			emit_signal("activate_skill")
	else:
		button.get_parent().skill_not_ready()