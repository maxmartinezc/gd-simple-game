extends Control

export(PackedScene) var lvl_block
export(PackedScene) var lvl_open
export (String) var path_scene_title_screen
var visible_world_level = 1
var world_lvls = []

func _ready():
	world_lvls = game.get_worlds_data()
	_load_world_levels(1)
		

func _on_HomeButton_pressed():
	get_tree().change_scene(path_scene_title_screen)


func _on_PrevButton_pressed():
	var prev_world = visible_world_level - 1
	if prev_world > 0:
		_load_world_levels(prev_world)

func _on_NextButton_pressed():
	var next_world = visible_world_level + 1
	if world_lvls.size() >= next_world:
		_load_world_levels(next_world)

func _load_world_levels(world):
	for i in $TextureRect/GridContainer.get_children():
    	i.queue_free()

	for item in world_lvls:
		if item.world == world:
			for lvl in item.levels:
				var child = null
				if lvl.open == true:
					child = lvl_open.instance()
					$TextureRect/GridContainer.add_child(child)
					print(lvl)
					child.initialize(item.world, lvl)
				else:
					child = lvl_block.instance()
					$TextureRect/GridContainer.add_child(child)
					
	visible_world_level = world
	$WorldLabel.set_text("World " + str(visible_world_level))