extends RigidBody2D

export (int) var coins_to_winner = 1
export (int) var speed = 1
export var longitude = Vector2(100, 0)
export (int) var type = 1
signal win(coins_to_winner, health)

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("win", game, "level_complete")
	var screen_width = get_viewport_rect().size.x
	set_global_position(Vector2((screen_width/2) - longitude.x/2, position.y))
	move()

func move():
	if type > 0:
		var twen_trans = null
		match type:
			1:
				twen_trans = Tween.TRANS_LINEAR
			# "increchendo"
			2:
				twen_trans = Tween.TRANS_EXPO
			# elastico
			3: 
				twen_trans = Tween.TRANS_ELASTIC
			4:
				twen_trans = Tween.TRANS_BACK
	
		$Tween.interpolate_property(self,
			"position",
			global_position,
			global_position + longitude,
			speed,
			twen_trans,
			Tween.EASE_IN_OUT
		)
	
		$Tween.start()
	
func _on_Tween_tween_completed(object, key):
	longitude *= -1
	move()


func _on_Area2D_body_entered(body):
	emit_signal("win", coins_to_winner, body.get_node("Health").get_health())
