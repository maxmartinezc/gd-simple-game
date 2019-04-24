extends RigidBody2D


export (int) var speed = 4
export var longitude = Vector2(300, 0)
export (int) var type = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	move()

func move():
	# default 1 (normal)
	var twen_trans = Tween.TRANS_LINEAR
	match type:
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
