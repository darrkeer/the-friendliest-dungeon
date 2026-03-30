extends StateWithAnimation

@export var player : CharacterBody3D

func fixed_update(_delta : float) -> void:
	if not player.is_on_floor():
		state_machine.change_state("fall")
		return
	
	if InputController.is_throw_pressing():
		state_machine.change_state("throw")
		return
	
	if InputController.is_interact_pressing():
		GameController.player.inventory.use_item()
	
	if InputController.is_jump_pressing():
		state_machine.change_state("jump")
		return
	
	if InputController.move_dir != Vector2.ZERO and InputController.is_sneak_pressing():
		state_machine.change_state("sneak")
		return
	
	if InputController.move_dir != Vector2.ZERO:
		state_machine.change_state("run")
		return
	
	player.velocity.x = 0
	player.velocity.z = 0
	
	player.move_and_slide()
