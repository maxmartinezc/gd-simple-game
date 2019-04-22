extends VBoxContainer

const TEXTURE_LEVELS = "res://gui/level-select/l*.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Stars/one.visible = false
	$Stars/two.visible = false
	$Stars/three.visible = false

func initialize(lvl_data):
	# conectar evento pressed
	$Button.connect("pressed", self, "_on_LevelButton_pressed", [lvl_data.id])
	# set image level number
	$Button.set_normal_texture(load(TEXTURE_LEVELS.replace("*", lvl_data.id)))
	# show stars
	for i in range(lvl_data.stars):
		$Stars.get_children()[i].visible = true

func _on_LevelButton_pressed(lvl):
	game.load_level(lvl)