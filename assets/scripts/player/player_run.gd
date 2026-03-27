extends StateWithAnimation

@export var sound_timer : Timer
@export var player : Player

func prepare() -> void:
	super()
	sound_timer.timeout.connect(_on_sound_timer_timeout)

func _on_sound_timer_timeout() -> void:
	if is_in_state:
		SFXController.play_sound("walk", GameController.player.global_position)

func fixed_update(delta : float) -> void:
	if not player.is_on_floor():
		state_machine.change_state("fall")
		return
	
	if InputController.is_throw_pressing():
		state_machine.change_state("throw")
		return
	
	if InputController.move_dir == Vector2.ZERO:
		state_machine.change_state("idle")
		return
	
	if InputController.is_jump_pressing():
		state_machine.change_state("jump")
		return
	
	if InputController.is_sneak_pressing():
		state_machine.change_state("sneak")
		return
	
	player.move_and_rotate(player.move_speed, delta)
	
	player.move_and_slide()
