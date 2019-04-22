extends "res://character.gd"

signal go_in(coins_to_winner)
export (int) var coins_to_winner = 1
export (int) var SPEED = 30
const STOP_THRESHOLD = 1e-2
export (Vector2) var _direction = Vector2(-1,0)
export (int) var PATROL_DISTANCE = 50
var _target_position = Vector2()

func _init():
	_transitions = {
		[States.IDLE, Events.WALK]: States.WALK,
		[States.WALK, Events.STOP]: States.IDLE
	}
	
func _ready():
	_setup()

func _physics_process(delta):	
	match state:
		States.WALK:
			_walk()

func enter_state():
	match state:
		States.IDLE:
			$PatrolTimer.start()
		States.WALK:
			_direction.x *= -1
			_target_position = position + PATROL_DISTANCE * _direction

# movimientos
func _walk():
	var velocity = _direction * SPEED
	move_and_slide(velocity)

	if (position - _target_position).length() < STOP_THRESHOLD:
		change_state(Events.STOP)
		
func _setup():
	var screen_width = get_viewport_rect().size.x
	set_global_position(Vector2((screen_width/2) - PATROL_DISTANCE/2, position.y))
	# timer patrullar
	$PatrolTimer.connect("timeout", self, "change_state", [Events.WALK])
	$PatrolTimer.wait_time = 0.5 + 1.5 * randf()
	$PatrolTimer.start()
	
	
func _on_Area2D_body_entered(body):
	game.level_complete(coins_to_winner, 3)