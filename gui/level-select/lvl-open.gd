extends VBoxContainer

const TEXTURE_LEVELS = "res://gui/level-select/assets/l*.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	$Stars/one.visible = false
	$Stars/two.visible = false
	$Stars/three.visible = false

func initialize(world, level):
	# conectar evento pressed
	$Button.connect("pressed", self, "_on_LevelButton_pressed", [world, level.id])
	# set image level number
	$Button.set_normal_texture(load(TEXTURE_LEVELS.replace("*", level.id)))
	# show stars
	for i in range(level.stars):
		$Stars.get_children()[i].visible = true

func _on_LevelButton_pressed(world, lvl):
	SoundFx.play_fx("Switchy")
	game.load_level(world,lvl)
