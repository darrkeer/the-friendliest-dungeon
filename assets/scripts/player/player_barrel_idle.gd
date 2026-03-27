extends PlayerBarrelState

func fixed_update(_delta : float) -> void:
	if not player.is_on_floor():
		state_machine.change_state("barrel_fall")
		return
	
	if InputController.is_throw_pressing():
		state_machine.change_state("idle")
		spawn_barrel()
		return
	
	if InputController.move_dir != Vector2.ZERO:
		state_machine.change_state("barrel_run")
		return
	
	player.velocity.x = 0
	player.velocity.z = 0
	
	player.move_and_slide()
