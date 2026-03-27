extends Resource
class_name PlayerEffect

@export var duration : float

var applied_already = false

func enter() -> void:
	applied_already = true

func exit() -> void:
	applied_already = false

func apply() -> void:
	var exited = false
	if applied_already:
		exited = true
		exit()
	enter()
	await Utils.create_one_shot_timer(duration).timeout
	if not exited:
		exit()
