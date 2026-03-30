extends StateWithAnimation

@export var player : Player
@export var start_fall_timer : Timer

func enter(_options := {}) -> void:
	super()
	start_fall_timer.start()

func exit() -> void:
	super()
	SFXController.play_sound("fall", GameController.player.global_position)

func fixed_update(delta : float) -> void:
	if player.is_on_floor() and start_fall_timer.is_stopped():
		state_machine.change_state("idle")
		return
	
	player.move_and_rotate(player.move_speed * Player.IN_AIR_SPEED_MUL, delta)
	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
