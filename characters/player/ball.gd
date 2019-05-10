extends "res://characters/character.gd"

export (bool) var enabled_light = false
export (int) var speed setget set_speed

signal death()
var impulse = Vector2()
var offset = Vector2()

var animated_sprite_node

func _ready():
	animated_sprite_node = get_node("../AnimatedSprite")
	$Light2D.enabled = enabled_light
	get_node("../Health").connect("take_damage", self, "_on_Health_take_damage")
	get_node("../Health").connect("invincible", self, "_on_Health_invincible")
	get_node("../Health").connect("recover_health", self, "_on_Health_recover")
	animated_sprite_node.connect('animation_finished', self, "_on_animation_finished")

func _init():
	_transitions = {
		[States.IDLE, Events.WALK]: States.WALK,
		[States.IDLE, Events.DOT_HIT]: States.DOT_HIT,
		[States.IDLE, Events.JUMP]: States.JUMP,
		
		[States.WALK, Events.IDLE]: States.IDLE,
		[States.WALK, Events.JUMP]: States.JUMP,
		[States.WALK, Events.DOT_HIT]: States.DOT_HIT,
		[States.WALK, Events.BUMP]: States.BUMP,
		[States.WALK, Events.INVINCIBLE]: States.INVINCIBLE,
		[States.WALK, Events.FALL]: States.FALL,

		[States.DOT_HIT, Events.WALK]: States.WALK,
		[States.DOT_HIT, Events.DEATH]: States.DEATH,
		[States.DOT_HIT, Events.BUMP]: States.BUMP,
		[States.DOT_HIT, Events.FALL]: States.FALL,
		
		[States.JUMP, Events.IDLE]: States.IDLE,
		[States.JUMP, Events.WALK]: States.WALK,
		[States.JUMP, Events.DOT_HIT]: States.DOT_HIT,
		[States.JUMP, Events.BUMP]: States.BUMP,
		[States.JUMP, Events.INVINCIBLE]: States.INVINCIBLE,
		[States.JUMP, Events.FALL]: States.FALL,
		
		[States.FALL, Events.WALK]: States.WALK,
		[States.FALL, Events.INVINCIBLE]: States.INVINCIBLE,
		[States.FALL, Events.DOT_HIT]: States.DOT_HIT,
		[States.FALL, Events.DEATH]: States.DEATH,
		[States.FALL, Events.IDLE]: States.IDLE,
			
		[States.BUMP, Events.IDLE]: States.IDLE,
		[States.BUMP, Events.DOT_HIT]: States.DOT_HIT,
		
		[States.INVINCIBLE, Events.WALK]: States.WALK,
		[States.INVINCIBLE, Events.IDLE]: States.IDLE
	}

func enter_state():
	match state:
		States.IDLE:
			animated_sprite_node.visible = false
			continue
		States.JUMP:
			_jump()
		States.BUMP:
			_bump()
		States.INVINCIBLE: 
			_invincible()
		States.DOT_HIT:
			_damage()
		States.DEATH:
			_death()
			
func _on_Gamepad_shoot(stick_vector, stick_speed, stick_speed_percentage):
	var shoot_speed = float(stick_speed_percentage)/100 * speed
	offset = Vector2()
	impulse = Vector2((stick_vector.x * (stick_speed + speed/4)), shoot_speed * -1)
	change_state(Events.JUMP)
		
func _bump():
	apply_impulse(offset, impulse)
	change_state(Events.FALL)
	
func _jump():
	SoundFx.play_fx("Jump")
	apply_impulse(offset, impulse)
	change_state(Events.FALL)

func _damage():
	SoundFx.play_fx("Hit")
	animated_sprite_node.play("damage")
	change_state(Events.IDLE)
	
func _invincible():
	animated_sprite_node.play("invincible")

func _death():
	emit_signal("death")
	
func _on_Health_take_damage(new_health):
	if new_health == 0:
		change_state(Events.DEATH)
	else:
		change_state(Events.DOT_HIT)

func _on_Health_invincible(value):
	if value:
		change_state(Events.INVINCIBLE)
	else:
		print(state)
		change_state(Events.IDLE)

func _on_Health_recover(v):
	SoundFx.play_fx("PowerUp")
	animated_sprite_node.play("health")
	
func _on_Ball_body_shape_entered(body_id, body, body_shape, local_shape):
	if body.is_in_group("platform"):
		if body.global_position.y > global_position.y:
			change_state(Events.WALK)
		else:
			SoundFx.play_fx("Boom")
	elif body.name == 'Bottom':
		change_state(Events.WALK)
	elif body.name == 'Right':
		offset = Vector2()
		impulse =  Vector2(-10, 0)
		change_state(Events.BUMP)
	elif body.name == 'Left':
		offset = Vector2()
		impulse =  Vector2(10, 0)
		change_state(Events.BUMP)

	
func set_speed(_speed):
	speed = _speed

func _on_Ball_body_shape_exited(body_id, body, body_shape, local_shape):
	change_state(Events.FALL)
