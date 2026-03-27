extends PlayerBarrelState

var is_stopped = false

func enter(_options := {}) -> void:
	super()
	is_stopped = false
	Utils.create_one_shot_timer(Player.START_FALL_TIME).timeout.connect(
		func(): is_stopped = true
	)

func fixed_update(delta : float) -> void:
	if player.is_on_floor() and is_stopped:
		state_machine.change_state("barrel_idle")
		return
	
	player.slide_and_rotate(player.move_speed * Player.SNEAK_SPEED_MUL, delta)
	
	player.velocity += player.get_gravity() * delta
	player.move_and_slide()
