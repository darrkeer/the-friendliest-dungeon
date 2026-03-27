extends PlayerEffect
class_name SpeedEffect

@export var multiplier : float

func enter() -> void:
	super()
	GameController.player.move_speed *= multiplier
	GameController.player.horizontal_jump_velocity *= multiplier

func exit() -> void:
	super()
	GameController.player.move_speed /= multiplier
	GameController.player.horizontal_jump_velocity /= multiplier
