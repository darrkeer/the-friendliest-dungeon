extends PlayerEffect
class_name JumpBoostEffect

@export var multiplier : float

func enter() -> void:
	super()
	GameController.player.vertical_jump_velocity *= multiplier

func exit() -> void:
	super()
	GameController.player.vertical_jump_velocity /= multiplier
