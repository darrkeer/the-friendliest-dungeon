extends StateWithAnimation

@export var player : Player

@export var fall_start_timer : Timer
@export var jump_start_timer : Timer

func enter(_options := {}) -> void:
	super()
	player.velocity = Vector3.UP * player.vertical_jump_velocity
	jump_start_timer.start()
	fall_start_timer.start()
	SFXController.play_sound("jump", GameController.player.global_position)

func fixed_update(delta : float) -> void:
	if fall_start_timer.is_stopped():
		state_machine.change_state("fall")
		return
	
	if jump_start_timer.is_stopped() and player.is_on_floor():
		state_machine.change_state("idle")
		return
	
	player.move_and_rotate(player.move_speed * Player.IN_AIR_SPEED_MUL, delta)
	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
