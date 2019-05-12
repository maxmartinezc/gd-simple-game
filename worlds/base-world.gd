extends Node2D
export (int) var top_body_damage = 10
func _ready():
	_setup()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		_on_Back_pressed()
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		_on_Back_pressed()

func _on_Back_pressed():
	var ev = InputEventAction.new()
	# set as pause, pressed
	ev.set_action("pause")
	ev.set_pressed(true)
	# feedback
	Input.parse_input_event(ev)
	
func level_time_out():
	$GUIS/GameOver.show()
	
func _on_Ball_take_damage(new_health):
	$GUIS/Header.set_life_bar_value(new_health)
	$Camera2D/Shaker.screen_shake(1,10,100)
	
func _on_Health_recover_health(new_health):
	$GUIS/Header.set_life_bar_value(new_health)
	
func _on_Ball_death():
	$GUIS/GameOver.show()

func _on_Top_body_entered(body):
	body.get_node("../Health").take_damage(top_body_damage)
	
func _setup():
	$Player/Health.connect("take_damage", self, "_on_Ball_take_damage")
	$Player/Health.connect("recover_health", self, "_on_Health_recover_health")
	$Player/Ball.connect("death", self, "_on_Ball_death")
	$GUIS/Header.connect("time_out", self, "level_time_out")
	$GUIS/Header.set_coins(game.get_score())
	_connect_coins()

func _connect_coins():
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("collect_coin", self, "_on_Coin_collected")

func _on_Coin_collected(amount):
	game.level_coin_collected(amount)
	$GUIS/Header.set_coins(game.get_coins())