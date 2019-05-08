extends "res://characters/character.gd"

export (String) var animated_sprite
export (bool) var enabled_light = false

func _ready():
	$Light2D.enabled = enabled_light

func _init():
	_transitions = {
		[States.WALK, Events.JUMP]: States.JUMP,
		[States.WALK, Events.DOT_HIT]: States.DOT_HIT,

		[States.DOT_HIT, Events.WALK]: States.WALK,
		[States.DOT_HIT, Events.DIE]: States.DIE,
		
		[States.JUMP, Events.DOT_HIT]: States.DOT_HIT,
		
		[States.DIE, Events.DEATH]: States.DEATH
	}

func enter_state():
	match state:
		States.WALK, States.JUMP: 
			get_node(animated_sprite).visible = false
		
		States.DOT_HIT:
			get_node(animated_sprite).play("damage")
			
		States.DIE:
			get_node(animated_sprite).play("die")
		
		States.DEATH:
			get_node(animated_sprite).play("death")
			
func _jump():
	pass
	
func _die():
	pass