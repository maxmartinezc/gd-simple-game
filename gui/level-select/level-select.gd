extends Control

export(PackedScene) var lvl_block
export(PackedScene) var lvl_open
export (String) var path_scene_title_screen

func _ready():
	for lvl in game.get_levels_data():
		var item = null
		if lvl.open == true:
			item = lvl_open.instance()
			$TextureRect/GridContainer.add_child(item)
			item.initialize(lvl)
		else:
			item = lvl_block.instance()
			$TextureRect/GridContainer.add_child(item)

func _on_HomeButton_pressed():
	get_tree().change_scene(path_scene_title_screen)


func _on_PrevButton_pressed():
	#load prev
	pass


func _on_NextButton_pressed():
	#load next
	pass # Replace with function body.
