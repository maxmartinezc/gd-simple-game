extends Node

const SAVE_PATH = "user://save.json"
var save_file

# Called when the node enters the scene tree for the first time.
func _init():
	#print(OS.get_user_data_dir())
	save_file = File.new()

func save_game(data):
    save_file.open(SAVE_PATH, File.WRITE)
    save_file.store_line(to_json(data))
    save_file.close()
	
func load_game():
	if !save_file.file_exists(SAVE_PATH):
		print("[SAVE-GAME] The save file does not exist.")
		return
	
	save_file.open(SAVE_PATH, File.READ)
	var data = parse_json(save_file.get_as_text())
	return data
	
func is_new_game():
	return !save_file.file_exists(SAVE_PATH)