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
	for p in $Background.get_children():
		if p.is_playing():
			p.stop()
			
func stop_fx(sfx):
	var p = get_node("Fx/" + sfx)
	p.stop()