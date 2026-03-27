extends Node

var move_dir = Vector2.ZERO

func is_jump_pressing() -> bool:
	return Input.is_action_pressed("jump")

func is_sneak_pressing() -> bool:
	return Input.is_action_pressed("sneak")

func get_real_move_dir() -> Vector3:
	return Vector3(move_dir.x, 0, move_dir.y)

func _process(_delta: float) -> void:
	move_dir = Input.get_vector("move_left", "move_right", "move_down", "move_up")

func is_interact_pressing() -> bool:
	return Input.is_action_just_pressed("interact")

func is_throw_pressing() -> bool:
	return Input.is_action_just_pressed("throw")

func is_pausing() -> bool:
	return Input.is_action_just_pressed("pause")
