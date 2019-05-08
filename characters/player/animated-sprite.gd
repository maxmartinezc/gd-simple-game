extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var offset = Vector2(0, 0) # simple offset for the health bar, 
	position = get_node("../Ball").position + offset

func damage():
	visible = true
	frame = 0
	play("damage")

func _on_AnimatedSprite_animation_finished():
	visible = false
