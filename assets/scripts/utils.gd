extends Node

func create_one_shot_timer(time : float, in_pause=false) -> SceneTreeTimer:
	return get_tree().create_timer(time, in_pause)

func create_repeated_timer(time : float, in_pause=false) -> Timer:
	var timer = Timer.new()
	add_child(timer)
	timer.ignore_time_scale = in_pause
	timer.wait_time = time
	timer.one_shot = false
	timer.start()
	return timer
