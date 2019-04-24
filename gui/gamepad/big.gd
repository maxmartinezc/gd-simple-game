extends Sprite

const RADIUS = 75
const SMALL_RADIUS = 35

var stick_pos
var evt_index = -1

func _init():
	stick_pos = position

func _input(event):
	if event is InputEventScreenTouch:
		if event.is_pressed():
			if stick_pos.distance_to(event.position) < RADIUS:
				evt_index = event.index
		elif evt_index != -1:
			if evt_index == event.index:
				evt_index = -1
				$Small.position = Vector2()
				$"../".stick_vector = Vector2()
				$"../".stick_angle = 0
				$"../".stick_speed = 0
	
	if evt_index != -1 && event is InputEventScreenDrag:
		var dist = stick_pos.distance_to(event.position)
		if dist + SMALL_RADIUS > RADIUS:
			dist = RADIUS - SMALL_RADIUS
			
		var vect = (event.position - stick_pos).normalized()
		var ang = event.position.angle_to_point(stick_pos)
		
		$"../".stick_vector = vect
		$"../".stick_angle = ang
		$"../".stick_speed = dist
		$Small.position = vect * dist
		
		