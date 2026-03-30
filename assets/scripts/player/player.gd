extends CharacterBody3D
class_name Player

const SNEAK_SPEED_MUL = 0.5
const IN_AIR_SPEED_MUL = 0.8
const START_FALL_TIME = 0.1
const MAX_HP = 3

@export var move_speed = 5.0
@export var horizontal_jump_velocity = 4.0
@export var vertical_jump_velocity = 6.0
@export var throw_velocity = 5.0

@export var camera : Node3D
@export var state_machine : StateMachine
@export var inventory : Inventory

var cur_hp = MAX_HP

func _ready() -> void:
	GameController.player = self
	GameController.player_ready.emit()

func slide_and_rotate(force, delta : float) -> void:
	var move_dir = get_rotated_move_dir()
	if move_dir:
		velocity += move_dir * delta * force

func move_and_rotate(force, _delta : float) -> void:
	velocity.x = 0
	velocity.z = 0
	slide_and_rotate(force, 1)

func is_dead() -> bool:
	return cur_hp == 0

func get_look_dir() -> Vector3:
	var cam_forward = -camera.global_basis.z
	cam_forward.y = 0
	cam_forward = cam_forward.normalized()
	return cam_forward

func change_health(amount : int) -> void:
	var prev_hp = cur_hp
	cur_hp += amount
	if cur_hp < 0:
		cur_hp = 0
	if cur_hp > MAX_HP:
		cur_hp = MAX_HP
	if cur_hp > prev_hp:
		for i in range(cur_hp - prev_hp):
			UIController.hpbar.add_heart()
	else:
		for i in range(prev_hp - cur_hp):
			UIController.hpbar.remove_heart()

func get_rotated_move_dir() -> Vector3:
	var cam_forward = get_look_dir()
	var cam_right = camera.global_basis.x
	cam_right.y = 0
	cam_right = cam_right.normalized()
	return (Basis(cam_right, Vector3.UP, cam_forward) * InputController.get_real_move_dir()).normalized()
