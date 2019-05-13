extends Control

export(PackedScene) var lvl_lock
export(PackedScene) var lvl_open
export (String) var path_scene_title_screen
var visible_world_level = 1
var world_lvls = []

func _ready():
	var data = game.get_current_level()
	SoundFx.play_background("Menu")
	world_lvls = game.get_worlds_data()
	_load_world_levels(data.world)
	$TextureRect/Levels/Score/Amount.set_text(str(game.get_score()))

func _on_HomeButton_pressed():
	SoundFx.play_fx("Switchy")
	get_tree().change_scene(path_scene_title_screen)

func _on_PrevButton_pressed():
	var prev_world = visible_world_level - 1
	if prev_world > 0:
		SoundFx.play_fx("Select")
		_load_world_levels(prev_world)

func _on_NextButton_pressed():
	var next_world = visible_world_level + 1
	if world_lvls.size() >= next_world:
		SoundFx.play_fx("Select")
		_load_world_levels(next_world)

func _load_world_levels(world):
	for i in $TextureRect/Levels/GridContainer.get_children():
	 	i.queue_free()

	for item in world_lvls:
		if item.world == world:
			for lvl in item.levels:
				var child = null
				if lvl.open == true:
					child = lvl_open.instance()
					$TextureRect/Levels/GridContainer.add_child(child)
					child.initialize(item.world, lvl)
				else:
					child = lvl_lock.instance()
					$TextureRect/Levels/GridContainer.add_child(child)
					
	visible_world_level = world
	$WorldLabel.set_text("World " + str(visible_world_level))
