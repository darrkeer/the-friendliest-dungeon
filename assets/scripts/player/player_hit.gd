extends StateWithAnimation

const PUNCH_FORCE = 3

@export var player : CharacterBody3D
@export var end_timer : Timer

var punch_vec : Vector3
var is_dead = false

func exit() -> void:
	super()
	player.velocity = punch_vec
	UIController.hpbar.remove_heart()

func enter(options := {}) -> void:
	super()
	punch_vec = player.global_position - options["origin"]
	punch_vec.y = 0
	punch_vec = (punch_vec.normalized() + Vector3.UP) * PUNCH_FORCE
	end_timer.start()
	player.cur_hp -= 1
	if player.is_dead():
		is_dead = true

func fixed_update(_delta : float) -> void:
	if end_timer.is_stopped():
		if not is_dead:
			state_machine.change_state("fall")
		else:
			player.look_at(player.global_position - Vector3(punch_vec.x, 0, punch_vec.z))
			state_machine.change_state("death")
		return
	
	
	player.velocity = Vector3.ZERO
	
	player.move_and_slide()
