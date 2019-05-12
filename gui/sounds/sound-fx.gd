extends Node2D

func play_fx(sfx):
	_play("Fx/" + sfx)

func play_background(sfx):
	_play("Background/" + sfx)

func _play(node_name):
	var p = get_node(node_name)
	if !p.is_playing():
		p.play(0)

func stop_background():
	_stop_all_bg()
			
func stop_fx(sfx):
	var p = get_node("Fx/" + sfx)
	p.stop()

func stop_all():
	_stop_all_bg()
	_stop_all_fx()

func _stop_all_fx():
	for p in $Fx.get_children():
		if p.is_playing():
			p.stop()
			
func _stop_all_bg():
	for p in $Background.get_children():
		if p.is_playing():
			p.stop()