extends Control

signal analog_released(stick_vector, stick_speed, stick_speed_percentage)

var stick_speed = 0
var stick_angle = 0
var stick_vector = Vector2()
var stick_speed_percentage = 0

const RADIUS = 100
const SMALL_RADIUS = 10

var stick_pos
var evt_index = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	stick_pos = $Big.position

func _gui_input(event):
	var released = false
	if event is InputEventScreenTouch:
		if event.is_pressed():
			if stick_pos.distance_to(event.position) < RADIUS:
				evt_index = event.index
		elif evt_index != -1 && evt_index == event.index:
			if stick_vector.y < 0:
				emit_signal("analog_released", stick_vector, stick_speed, stick_speed_percentage)

			evt_index = -1
			$Big/Small.position = Vector2()
			stick_vector = Vector2()
			stick_angle = 0
			stick_speed = 0
			stick_speed_percentage = 0
	
	if evt_index != -1 && event is InputEventScreenDrag:
		var dist = stick_pos.distance_to(event.position)
		if dist + SMALL_RADIUS > RADIUS:
			dist = RADIUS - SMALL_RADIUS
			
		var vect = (event.position - stick_pos).normalized()
		var ang = event.position.angle_to_point(stick_pos)
		
		stick_vector = vect
		stick_angle = ang
		stick_speed = dist
		stick_speed_percentage = _calculate_percentage(dist) 
		$Big/Small.position = vect * dist

func _calculate_percentage(v):
	var amount = float(v)/RADIUS * 100
	return round(amount + SMALL_RADIUS)
