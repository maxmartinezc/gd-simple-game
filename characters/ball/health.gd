extends Node

signal health_changed(health)

var health = 0
var max_health = 0
var status = null
enum STATUSES { NONE, INVINCIBLE }

func _ready():
	max_health = game.get_max_health()
	health = max_health
	_change_status(STATUSES.NONE)
	
func _change_status(new_status):
	status = new_status

func take_damage(amount):
	# invulnerable
	if status == STATUSES.INVINCIBLE:
		return
	
	health -= amount
	if health < 0:
		health = 0

	emit_signal("health_changed", health)

func recover_health(amount):
	health += amount	
	if health > max_health:
		health = max_health
	
	emit_signal("health_changed", health)
