extends Control

export(PackedScene) var lvl_block
export(PackedScene) var lvl_open

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