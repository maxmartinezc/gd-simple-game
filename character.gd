extends KinematicBody2D

enum States {
	IDLE,
	WALK
}

enum Events {
	INVALID=-1,
	STOP,
	IDLE,
	WALK
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
	
func _on_Health_health_depleted():
	change_state(Events.DIE)