extends PlayerBarrelState

@export var barrel_animation_player : AnimationPlayer
@export var sound_timer : Timer

func prepare() -> void:
	super()
	sound_timer.timeout.connect(_on_sound_timer_timeout)

func _on_sound_timer_timeout() -> void:
	if is_in_state:
		SFXController.play_sound("sneak_walk", GameController.player.global_position)

func enter(_options := {}) -> void:
	super()
	barrel_animation_player.play("barrel_run")

func exit() -> void:
	super()
	barrel_animation_player.play("barrel_idle")

func fixed_update(delta : float) -> void:
	if not player.is_on_floor():
		state_machine.change_state("barrel_fall")
		return
	
	if InputController.is_throw_pressing():
		state_machine.change_state("idle")
		spawn_barrel()
		return
	
	if InputController.move_dir == Vector2.ZERO:
		state_machine.change_state("barrel_idle")
		return
	
	player.move_and_rotate(player.move_speed * Player.SNEAK_SPEED_MUL, delta)
	
	player.move_and_slide()
