extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var offset = Vector2(0, 0) # simple offset for the health bar, 
	position = get_node("../Ball").position + offset

func play(anim="", backwards=false):
	visible = true
	frame = 0
	.play(anim)
	
func _on_AnimatedSprite_animation_finished():
	if animation != 'invincible':
		visible = false
