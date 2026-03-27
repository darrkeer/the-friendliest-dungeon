extends CharacterBody3D
class_name Player

const SNEAK_SPEED_MUL = 0.5
const IN_AIR_SPEED_MUL = 0.7
const START_FALL_TIME = 0.1
const HP = 3

@export var move_speed = 5.0
@export var horizontal_jump_velocity = 4.0
@export var vertical_jump_velocity = 6.0
@export var throw_velocity = 5.0

@export var camera : Node3D
@export var state_machine : StateMachine
@export var inventory : Inventory

var cur_hp = HP

func _ready() -> void:
	GameController.player = self
	GameController.player_ready.emit()

func slide_and_rotate(force, delta : float) -> void:
	var move_dir = get_rotated_move_dir()
	if move_dir:
		look_at(global_position + move_dir)
		velocity += move_dir * delta * force

func move_and_rotate(force, _delta : float) -> void:
	velocity = Vector3.ZERO
	slide_and_rotate(force, 1)

func is_dead() -> bool:
	return cur_hp == 0

func get_look_dir() -> Vector3:
	var cam_forward = -camera.global_basis.z
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()
	return cam_forward

func get_rotated_move_dir() -> Vector3:
	var cam_forward = get_look_dir()
	var cam_right = camera.global_basis.x
	cam_right.y = 0
	cam_right = cam_right.normalized()
	return (Basis(cam_right, Vector3.UP, cam_forward) * InputController.get_real_move_dir()).normalized()
