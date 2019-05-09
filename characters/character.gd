extends RigidBody2D

enum States {
	IDLE,
	WALK,
	BUMP,
	JUMP,
	FALL,
	INVINCIBLE,
	DEATH,
	DOT_HIT
}

enum Events {
	INVALID=-1,
	IDLE,
	WALK,
	BUMP,
	JUMP,
	FALL,
	INVINCIBLE,
	DIE,
	DEATH,
	DOT_HIT
}

var state = 0
var _transitions = {}


func enter_state():
	pass

func change_state(event):
	var transition = [state, event]
	if not transition in _transitions:
		return
	
	state = _transitions[transition]
	enter_state()
		