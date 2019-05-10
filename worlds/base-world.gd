extends Node2D
export (int) var top_body_damage = 10
func _ready():
	_setup()

func level_time_out():
	$GUIS/MenuLayer/GameOver.show()
	
func _on_Ball_take_damage(new_health):
	$GUIS/LifeLayer/Header.set_life_bar_value(new_health)
	$Camera2D/Shaker.screen_shake(1,10,100)
	
func _on_Health_recover_health(new_health):
	$GUIS/LifeLayer/Header.set_life_bar_value(new_health)
	
func _on_Ball_death():
	$GUIS/MenuLayer/GameOver.show()

func _on_Top_body_entered(body):
	body.get_node("../Health").take_damage(top_body_damage)
	
func _setup():
	$Player/Health.connect("take_damage", self, "_on_Ball_take_damage")
	$Player/Health.connect("recover_health", self, "_on_Health_recover_health")
	$Player/Ball.connect("death", self, "_on_Ball_death")
	$GUIS/LifeLayer/Header.connect("time_out", self, "level_time_out")
	_connect_coins()

func _connect_coins():
	for coin in get_tree().get_nodes_in_group("coins"):
		coin.connect("collect_coin", self, "_On_Coin_collected")

func _On_Coin_collected(amount):
	game.coin_collected(amount)
	$GUIS/LifeLayer/Header.set_coins(game.get_coins())