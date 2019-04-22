extends Control

var _speed = 0
var _can_increase_speed = false
var _increase_speed_direction = 1

export (int) var max_speed = 0
const INTERVAL_SPEED = 50

signal shoot(speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/Buttons/CenterContainer/TextureProgress.max_value = max_speed
	$ShootTimer.start()
	$ShootTimer.wait_time = 0.2

func _on_ShootTimer_timeout():
	var tmp = _speed + INTERVAL_SPEED * _increase_speed_direction
	if tmp <= max_speed && tmp >= 0 && _can_increase_speed:
		_speed = tmp
		$HBoxContainer/Buttons/PowerIndicator/Background/Number.set_text(str(_calculate_percentage()) + '%')
		$HBoxContainer/Buttons/CenterContainer/TextureProgress.set_value(_speed)
	else:
		print(tmp)

func _on_ShootButton_pressed():
	emit_signal("shoot", _speed)

func _on_UpButton_button_down():
	_can_increase_speed = true
	_increase_speed_direction = 1

func _on_DownButton_button_down():
	_can_increase_speed = true
	_increase_speed_direction = -1

func _on_UpButton_button_up():
	_can_increase_speed = false

func _on_DownButton_button_up():
	_can_increase_speed = false

func _calculate_percentage():
	var amount = float(_speed)/max_speed * 100
	return round(amount)