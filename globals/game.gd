extends Node

var _score = 0 setget , get_score
const SCENE_LEVEL_FOLDER_PATH = "res://levels"
const SCENE_PREFIX_NAME = SCENE_LEVEL_FOLDER_PATH + "/level*/Level*.tscn"
const SCENE_LEVEL_COMPLETE = "res://gui/level-complete/LevelComplete.tscn"

onready var save_game = preload("res://globals/save.gd").new()
var lvls = [] setget set_levels_data, get_levels_data
var lvl_complete_index = {}
var current_lvl = 1 setget , get_current_level

func _ready():
	var data = generate_game_data() if save_game.is_new_game() else save_game.load_game()
	_score = data.score
	set_levels_data(data.lvls)

func load_level(lvl):
	current_lvl = lvl
	get_tree().change_scene(SCENE_PREFIX_NAME.replace("*", lvl))

func level_complete(score, stars):
	# asignamos el indice del nivel completado
	lvl_complete_index = get_current_level() - 1
	# set stars in level
	lvls[lvl_complete_index].stars = stars
	# increase score
	lvls[lvl_complete_index].score = score
	#global score
	_score += score
	# unlock next level (solo si existe)
	if lvls.size() - 1 >= lvl_complete_index+1:
		lvls[lvl_complete_index+1].open = true
	else:
		print("END GAME")

	# save level complete
	save_game.save_game({
		"score": _score,
		"lvls": lvls
	})
	
	#load select level
	get_tree().change_scene(SCENE_LEVEL_COMPLETE)

func get_score():
	return _score

func get_level_complete():
	return lvls[lvl_complete_index]
	
func generate_game_data():
	var lvls_cfg = []
	
	var total_levels = _count_levels()
	# 0 .. total_levels - 1
	for i in range(total_levels):
		# solo el primer nivel esta abierto
		lvls_cfg.push_back({ 
			"id": i + 1, 
			"open": true if i == 0 else false, 
			"score": 0,
			"stars": 0
		})
	var game_data = { "score": 0, "lvls": lvls_cfg}
	return game_data

func set_levels_data(data):
	lvls = data

func get_levels_data():
	return lvls
	
func get_current_level():
	return current_lvl

func _count_levels():
	var count = 0
	var dir = Directory.new()
	if dir.open(SCENE_LEVEL_FOLDER_PATH) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while (file_name != ""):
			if dir.current_is_dir() && file_name.find("level",0):
				count += 1
			file_name = dir.get_next()
	return count
	
func reload_current_level():
	load_level(current_lvl)