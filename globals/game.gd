extends Node

var _score = 0 setget , get_score
const SCENE_WORLD_FOLDER_PATH = "res://worlds"
const SCENE_PREFIX_NAME = SCENE_WORLD_FOLDER_PATH + "/world-x-/Level-y-.tscn"
const SCENE_LEVEL_COMPLETE = "res://gui/level-complete/LevelComplete.tscn"
const SCENE_GAME_OVER = "res://gui/game-over/GameOver.tscn"
const MAX_HEALTH = 100
const MAX_STARS = 3

onready var save_game = preload("res://globals/save.gd").new()
var worlds = [] setget set_worlds_data, get_worlds_data
var current_lvl_index = 0 setget , get_current_level
var current_world_index = 0
# cantidad de monedas ganadas en el nivel, es temporal al nievel yse reinicia con cada nivel
var level_coins = 0 setget , get_coins
# mantiene el valor global del score para ser actualizado en el sistema de archivos
var global_score = 0
# almacenar el valor del score al momento de iniciar el nivel
var init_level_score = 0

func _ready():
	get_tree().set_quit_on_go_back(false)
	get_tree().set_auto_accept_quit(false)
	var data = generate_game_data() if save_game.is_new_game() else save_game.load_game()
	set_worlds_data(data.worlds)
	global_score = data.score

func load_level(world, lvl):
	SoundFx.stop_background()
	SoundFx.play_background("World" + str(world))
	_set_current_world_index_and_level(world, lvl)
	level_coins = 0
	init_level_score = global_score
	get_tree().change_scene(SCENE_PREFIX_NAME.replace("-x-", world).replace("-y-", lvl))

func level_complete(coins, health):
	#Detenemos la musica
	SoundFx.stop_all()
	SoundFx.play_fx("Win")

	worlds[current_world_index].levels[current_lvl_index].stars = _calculate_stars_to_winner(health)
	
	# increase score
	worlds[current_world_index].levels[current_lvl_index].score = level_coins + coins
	worlds[current_world_index].levels[current_lvl_index].coins = level_coins
	
	# unlock next world level (solo si existe)
	if worlds[current_world_index].levels.size() - 1 > current_lvl_index:
		# next level in world
		worlds[current_world_index].levels[current_lvl_index + 1].open = true
	# next world
	elif worlds[current_world_index].size() - 1 > current_world_index:
		worlds[current_world_index + 1].levels[0].open = true
	else:
		print("END GAME")
		
	global_score += level_coins
	# save level complete
	save_game.save_game({
		"score": global_score,
		"worlds": worlds
	})
	
	#load select level
	get_tree().change_scene(SCENE_LEVEL_COMPLETE)

func get_score():
	return global_score

func get_level_complete():
	return worlds[current_world_index].levels[current_lvl_index]
	
func generate_game_data():
	var worlds_cfg = []
	
	var worlds = _count_world_levels()
	for item in worlds:
		var lvls = []
		#0 ... item.levels - 1
		for l in range(item.levels):
			# solo el primer nivel esta abierto
			lvls.push_back({ 
				"id": l + 1, 
				"open": true if (l == 0 && item.world == 1) else false, 
				"score": 0,
				"coins": 0,
				"stars": 0
			})
		worlds_cfg.push_back({ "world": item.world, "levels": lvls})
	return { "score": 0, "worlds": worlds_cfg}

func set_worlds_data(data):
	worlds = data

func get_worlds_data():
	return worlds
	
func get_current_level():
	return { "world" : worlds[current_world_index].world, "level" : worlds[current_world_index].levels[current_lvl_index].id}
	
func _count_world_levels():
	var world_lvls = []
	# iteramos los worlds
	var total_worlds = find_files(SCENE_WORLD_FOLDER_PATH, "world", true)
	for i in range(total_worlds):
		var total_lvls = find_files(SCENE_WORLD_FOLDER_PATH + "/world" + str(i + 1), "Level", false)
		world_lvls.push_back({ "world": i + 1, "levels": total_lvls})
	
	return world_lvls
	
func reload_current_level():
	var data = get_current_level()
	load_level(data.world, data.level)
	
func find_files(path, name, find_dir):
	var count = 0
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin(true,true)
		var file_name = dir.get_next()
		while (file_name != ""):
			if find_dir: 
				if dir.current_is_dir() && file_name.find(name,0) > -1:
					count += 1
			elif file_name.find(name,0) > -1:
				count += 1
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	return count
	
func _set_current_world_index_and_level(world, level):
	var found = false
	for i in range(worlds.size()):
		if worlds[i].world == world:
			current_world_index = i
			for l in range(worlds[i].levels.size()):
				if worlds[i].levels[l].id == level:
					current_lvl_index = l
					found = true
					break
			if found:
				break

func get_max_health():
	return MAX_HEALTH

func game_over():
	get_tree().change_scene(SCENE_GAME_OVER)

func _calculate_stars_to_winner(health):
	var stars = 0
	# set stars in level
	if health == MAX_HEALTH:
		stars = MAX_STARS
	elif health >= 60:
		stars = MAX_STARS - 1
	elif health >= 30:
		stars = MAX_STARS - 2
	return stars
	
func level_coin_collected(amount):
	level_coins += amount

func use_coins(amount):
	global_score -= amount
	
func get_coins():
	return global_score + level_coins