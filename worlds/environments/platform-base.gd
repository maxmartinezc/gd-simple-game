extends RigidBody2D


export (int) var speed = 4
export var longitude = Vector2(300, 0)
export (int) var type = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	move()

func move():
	if type > 0:
		var twen_trans = null
		match type:
			# de un lado a otro
			1:
				twen_trans = Tween.TRANS_LINEAR
			# "increchendo"
			2:
				twen_trans = Tween.TRANS_EXPO
			# elastico
			3: 
				twen_trans = Tween.TRANS_ELASTIC
			4:
			# efecto al terminar el movimiento
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

func _on_PlatformBase_body_entered(body):
	if body.global_position.y > global_position.y:
		SoundFx.play_fx("Boom")
